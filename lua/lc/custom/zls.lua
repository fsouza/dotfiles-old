local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')

local M = {}

local add_to_config = function()
  configs.zls = {
    default_config = {
      cmd = {'zls'};
      filetypes = {'zig'};
      root_dir = function(fname)
        return nvim_lsp.util.find_git_ancestor(fname) or vim.loop.cwd()
      end;
    };
  }
end

function M.setup(opts)
  add_to_config()
  nvim_lsp.zls.setup(opts)
end

return M
