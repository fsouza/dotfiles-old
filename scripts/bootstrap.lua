local vfn = vim.fn
local loop = vim.loop

local second_ms = 1000
local minute_ms = 60 * second_ms

local cache_dir = vfn.stdpath('cache')
local site_dir = string.format('%s/site', vfn.stdpath('data'))

local pip_packages = {'pip'; 'pip-tools'; 'git+https://github.com/luarocks/hererocks.git'}

local rocks = {'lyaml'; 'luacheck'; 'luaposix'; 'tl'}

local debug = function(msg)
  if os.getenv('NVIM_DEBUG') then
    print('[DEBUG] ' .. msg)
  end
end

local fmt_execute = function(pat, ...)
  os.execute(string.format(pat, ...))
end

local download_virtualenv_pyz = function()
  local file_name = cache_dir .. '/virtualenv.pyz'
  if not loop.fs_stat(file_name) then
    fmt_execute([[curl -sLo %s https://bootstrap.pypa.io/virtualenv.pyz]], file_name)
  end
  return file_name
end

local ensure_virtualenv = function()
  local venv_dir = cache_dir .. '/venv'
  if not loop.fs_stat(venv_dir) then
    local venv_pyz = download_virtualenv_pyz()
    fmt_execute([[python3 %s -p python3 %s]], venv_pyz, venv_dir)
  end
  fmt_execute([[%s/venv/bin/pip install --upgrade %s -r ./langservers/requirements.txt]],
              cache_dir, table.concat(pip_packages, ' '))
  return venv_dir
end

local ensure_hererocks = function(virtualenv)
  local hr_dir = cache_dir .. '/hr'
  if not loop.fs_stat(hr_dir) then
    fmt_execute([[%s/bin/hererocks -j latest -r latest %s]], virtualenv, hr_dir)
  end

  for _, rock in pairs(rocks) do
    fmt_execute([[%s/bin/luarocks install %s]], hr_dir, rock)
  end

  return hr_dir
end

local setup_langservers = function()
  fmt_execute([[./langservers/setup.sh %s/langservers]], cache_dir)
end

local install_autoload_plugins = function()
  vfn.mkdir(site_dir .. '/autoload', 'p')
  fmt_execute(
    [[curl -sLo %s/autoload.fzf.vim https://raw.githubusercontent.com/junegunn/fzf/HEAD/plugin/fzf.vim]],
    site_dir)
end

local ensure_packer_nvim = function()
  local packer_dir = string.format('%s/pack/packer/opt/packer.nvim', site_dir)
  vfn.mkdir(packer_dir, 'p')
  if not loop.fs_stat(packer_dir .. '/.git') then
    fmt_execute([[git clone --depth=1 https://github.com/wbthomason/packer.nvim %s]], packer_dir)
  end

  vim.o.packpath = string.format('%s,%s', site_dir, vim.o.packpath)
  require('packed').setup()
  require('packer').sync()
end

do
  local autoload_done = false
  local packer_done = false
  local langservers_done = false
  vim.schedule(function()
    install_autoload_plugins()
    autoload_done = true
  end)
  vim.schedule(function()
    setup_langservers()
    langservers_done = true
  end)
  vfn.mkdir(cache_dir, 'p')
  local virtualenv = ensure_virtualenv()
  debug(string.format('created virtualenv at "%s"\n', virtualenv))
  local hr_dir = ensure_hererocks(virtualenv)
  debug(string.format('created hererocks at "%s"\n', hr_dir))
  vim.schedule(function()
    ensure_packer_nvim()
    packer_done = true
  end)
  local timeout_min = 30
  local status = vim.wait(timeout_min * minute_ms, function()
    return autoload_done and packer_done and langservers_done
  end, 25)
  if not status then
    error(string.format('timed out after %d minutes', timeout_min))
  end
end
