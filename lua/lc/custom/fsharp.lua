local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')

local M = {}

local add_to_config = function()
  configs.fsharp_language_server = {
    default_config = {
      cmd = 'fsharp-language-server';
      filetypes = {'fsharp'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end;
      settings = {};
    };
  }
end

function M.setup(opts)
  add_to_config()
  nvim_lsp.fsharp_language_server.setup(opts)
end

return M
