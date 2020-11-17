local vfn = vim.fn
local loop = vim.loop

local second_ms = 1000
local minute_ms = 60 * second_ms

local cache_dir = vfn.stdpath('cache')
local site_dir = string.format('%s/site', vfn.stdpath('data'))

local rocks = {'lyaml'; 'luacheck'; 'luaposix'}

local debug = function(msg)
  if os.getenv('NVIM_DEBUG') then
    print('[DEBUG] ' .. msg)
  end
end

local execute = function(pat, ...)
  local cmd = string.format(pat, ...)
  local status = os.execute(cmd)
  if status ~= 0 then
    error(string.format(
            '================\ncommand "%s" exitted with status %d\n================\n', cmd,
            status))
  end
end

local download_virtualenv_pyz = function()
  local file_name = cache_dir .. '/virtualenv.pyz'
  if not loop.fs_stat(file_name) then
    execute([[curl -sLo %s https://bootstrap.pypa.io/virtualenv.pyz]], file_name)
  end
  return file_name
end

local ensure_virtualenv = function()
  local venv_dir = cache_dir .. '/venv'
  if not loop.fs_stat(venv_dir) then
    local venv_pyz = download_virtualenv_pyz()
    execute([[python3 %s -p python3 %s]], venv_pyz, venv_dir)
  end
  execute([[%s/venv/bin/pip install --upgrade -r ./langservers/requirements.txt]], cache_dir)
  return venv_dir
end

local download_hererocks_py = function()
  local file_name = cache_dir .. '/hererocks.py'
  if not loop.fs_stat(file_name) then
    execute(
      [[curl -sLo %s https://raw.githubusercontent.com/luarocks/hererocks/master/hererocks.py]],
      file_name)
  end
  return file_name
end

local ensure_hererocks = function()
  local hr_dir = cache_dir .. '/hr'
  if not loop.fs_stat(hr_dir) then
    local hererocks_py = download_hererocks_py()
    execute([[python3 %s -j latest -r latest %s]], hererocks_py, hr_dir)
  end

  for _, rock in pairs(rocks) do
    execute([[%s/bin/luarocks install %s]], hr_dir, rock)
  end

  return hr_dir
end

local setup_langservers = function()
  execute([[./langservers/setup.sh %s/langservers]], cache_dir)
end

local install_autoload_plugins = function()
  vfn.mkdir(site_dir .. '/autoload', 'p')
  execute(
    [[curl -sLo %s/autoload.fzf.vim https://raw.githubusercontent.com/junegunn/fzf/HEAD/plugin/fzf.vim]],
    site_dir)
end

local ensure_packer_nvim = function()
  local packer_dir = string.format('%s/pack/packer/opt/packer.nvim', site_dir)
  vfn.mkdir(packer_dir, 'p')
  if not loop.fs_stat(packer_dir .. '/.git') then
    execute([[git clone --depth=1 https://github.com/wbthomason/packer.nvim %s]], packer_dir)
  end

  vim.o.packpath = string.format('%s,%s', site_dir, vim.o.packpath)
  require('fsouza.packed').setup()
  require('packer').sync()
end

do
  local ops = {
    autoload = install_autoload_plugins;
    langservers = setup_langservers;
    packer = ensure_packer_nvim;
    virtualenv = ensure_virtualenv;
    hererocks = ensure_hererocks;
  }
  local done = {}

  local sched = function(name, fn)
    vim.schedule(function()
      fn()
      done[name] = true
    end)
  end

  vfn.mkdir(cache_dir, 'p')
  for name, fn in pairs(ops) do
    sched(name, fn)
  end

  local timeout_min = 30
  local status = vim.wait(timeout_min * minute_ms, function()
    for name in pairs(ops) do
      if not done[name] then
        return false
      end
    end
    return true
  end, 25)
  if not status then
    error(string.format('timed out after %d minutes', timeout_min))
  end
end
