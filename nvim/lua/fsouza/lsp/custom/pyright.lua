local loop = vim.loop

local M = {}

local function set_from_env_var(settings)
  local virtual_env = os.getenv('VIRTUAL_ENV')
  if virtual_env then
    settings.python.pythonPath = string.format('%s/bin/python', virtual_env)
    return true
  end
  return false
end

local function set_from_poetry(settings)
  if loop.fs_stat('poetry.lock') then
    local f = io.popen('poetry env info -p 2>/dev/null', 'r')
    if f then
      local virtual_env = f:read()
      settings.python.pythonPath = string.format('%s/bin/python', virtual_env)
      f:close()
      return true
    end
  end
  return false
end

local function set_from_pipenv(settings)
  if loop.fs_stat('Pipfile.lock') then
    local f = io.popen('pipenv --venv')
    if f then
      local virtual_env = f:read()
      settings.python.pythonPath = string.format('%s/bin/python', virtual_env)
      f:close()
      return true
    end
  end
  return false
end

local function detect_virtual_env(settings)
  local detectors = {set_from_env_var; set_from_poetry; set_from_pipenv}
  for _, detect in ipairs(detectors) do
    if detect(settings) then
      return
    end
  end
end

local function pyright_settings()
  local settings = {
    pyright = {};
    python = {
      analysis = {
        autoImportCompletions = true;
        autoSearchPaths = true;
        diagnosticMode = 'workspace';
        typeCheckingMode = vim.g.pyright_type_checking_mode or 'basic';
        useLibraryCodeForTypes = true;
      };
    };
  }
  detect_virtual_env(settings)
  return settings
end

function M.get_opts(opts)
  if not opts.root_dir then
    opts.root_dir = require('fsouza.lsp.opts').root_pattern_with_fallback('.git')
  end
  opts.settings = pyright_settings()
  return opts
end

return M
