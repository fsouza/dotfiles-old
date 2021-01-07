local vfn = vim.fn
local loop = vim.loop

local second_ms = 1000
local minute_ms = 60 * second_ms

local cache_dir = vfn.stdpath('cache')
local site_dir = string.format('%s/site', vfn.stdpath('data'))

local function execute(pat, ...)
  local cmd = string.format(pat, ...)
  local status = os.execute(cmd)
  if status ~= 0 then
    error(string.format(
            '================\ncommand "%s" exitted with status %d\n================\n', cmd,
            status))
  end
end

local function download_virtualenv_pyz()
  local file_name = cache_dir .. '/virtualenv.pyz'
  if not loop.fs_stat(file_name) then
    execute([[curl -sLo %s https://bootstrap.pypa.io/virtualenv.pyz]], file_name)
  end
  return file_name
end

local function ensure_virtualenv()
  local venv_dir = cache_dir .. '/venv'
  if not loop.fs_stat(venv_dir) then
    local venv_pyz = download_virtualenv_pyz()
    execute([[python3 %s -p python3 %s]], venv_pyz, venv_dir)
  end
  execute([[%s/venv/bin/pip install --upgrade -r ./langservers/requirements.txt]], cache_dir)
  return venv_dir
end

local function download_hererocks_py()
  local file_name = cache_dir .. '/hererocks.py'
  if not loop.fs_stat(file_name) then
    execute(
      [[curl -sLo %s https://raw.githubusercontent.com/luarocks/hererocks/master/hererocks.py]],
      file_name)
  end
  return file_name
end

local function ensure_hererocks()
  local hr_dir = cache_dir .. '/hr'
  if not loop.fs_stat(hr_dir) then
    local hererocks_py = download_hererocks_py()
    execute([[python3 %s -j latest -r latest %s]], hererocks_py, hr_dir)
  end

  execute([[%s/bin/luarocks make]], hr_dir)
  return hr_dir
end

local function setup_langservers()
  execute([[./langservers/setup.sh %s/langservers]], cache_dir)
end

local function install_autoload_plugins()
  vfn.mkdir(site_dir .. '/autoload', 'p')
  execute(
    [[curl -sLo %s/autoload/fzf.vim https://raw.githubusercontent.com/junegunn/fzf/HEAD/plugin/fzf.vim]],
    site_dir)
end

do
  local ops = {
    autoload = install_autoload_plugins;
    langservers = setup_langservers;
    virtualenv = ensure_virtualenv;
    hererocks = ensure_hererocks;
  }
  local done = {}

  local function sched(name, fn)
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
    local parts = {string.format('timed out after %d minutes', timeout_min)}
    for k, _ in pairs(ops) do
      table.insert(parts, string.format('%s = %s', k, done[k] or false))
    end
    error(table.concat(parts, '\n'))
  end
end
