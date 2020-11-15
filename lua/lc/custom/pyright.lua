local loop = vim.loop

local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')

local M = {}

local set_from_poetry = function(settings)
  if loop.fs_stat('poetry.lock') then
    local f = io.popen('poetry env info -p 2>/dev/null', 'r')
    if f then
      local virtual_env = f:read()
      settings.python.pythonPath = string.format('%s/bin/python', virtual_env)
      f:close()
    end
  end
end

local set_from_env_var = function(settings)
  local virtual_env = os.getenv('VIRTUAL_ENV')
  if virtual_env then
    settings.python.pythonPath = string.format('%s/bin/python', virtual_env)
    return true
  end
  return false
end

local detect_virtual_env = function(settings)
  local modified = set_from_env_var(settings)
  if not modified then
    set_from_poetry(settings)
  end
end

local pyright_settings = function()
  local settings = {
    pyright = {disableOrganizeImports = true};
    python = {
      analysis = {
        autoImportCompletions = true;
        autoSearchPaths = true;
        diagnosticMode = 'workspace';
        typeCheckingMode = 'strict';
        useLibraryCodeForTypes = true;
      };
    };
  }
  detect_virtual_env(settings)
  return settings
end

local add_to_config = function()
  configs.pyright = {
    default_config = {
      cmd = {'pyright-langserver'; '--stdio'};
      filetypes = {'python'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.cwd()
      end;
      settings = pyright_settings();
      before_init = function(initialize_params)
        initialize_params['workspaceFolders'] = {
          {name = 'workspace'; uri = initialize_params['rootUri']};
        }
      end;
    };
  }
end

function M.setup(opts)
  add_to_config()
  nvim_lsp.pyright.setup(opts)
end

return M
