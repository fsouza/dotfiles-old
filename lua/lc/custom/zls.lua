local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

local M = {}

local add_to_config = function()
  configs.zls = {
    default_config = {
      cmd = {'zls'};
      filetypes = {'zig'};
      root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or vim.loop.cwd()
      end;
    };
  }
end

function M.setup(opts)
  add_to_config()
  lspconfig.zls.setup(opts)
end

return M
