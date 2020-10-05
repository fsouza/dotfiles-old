local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')

local M = {}

local split_path = function(p)
  local parts = vim.split(p, '/');
  local filename = table.remove(parts, #parts);
  return table.concat(parts, '/'), filename
end

local pyright_settings = function()
  local settings = {analysis = {autoSearchPaths = true}; pyright = {useLibraryCodeForTypes = true}}
  local virtual_env = os.getenv('VIRTUAL_ENV')
  if virtual_env then
    local venv_path, venv = split_path(virtual_env)
    settings.pyright = {useLibraryCodeForTypes = true; venvPath = venv_path; venv = venv}
  end
  return settings
end

local add_to_config = function()
  configs.pyright = {
    default_config = {
      cmd = {'pyright-langserver'; '--stdio'};
      filetypes = {'python'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
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
