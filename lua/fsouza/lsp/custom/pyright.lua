local loop = vim.loop

local lspconfig = require('lspconfig')

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

local function pyright_settings(enable_typechecking)
  local settings = {
    pyright = {};
    python = {
      analysis = {
        autoImportCompletions = true;
        autoSearchPaths = true;
        diagnosticMode = 'workspace';
        typeCheckingMode = enable_typechecking and 'strict' or 'off';
        useLibraryCodeForTypes = true;
      };
    };
  }
  detect_virtual_env(settings)
  return settings
end

function M.get_opts(opts, enable_typechecking)
  enable_typechecking = enable_typechecking or true
  opts.root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.loop.cwd()
  end
  opts.settings = pyright_settings(enable_typechecking)
  return opts
end

return M
