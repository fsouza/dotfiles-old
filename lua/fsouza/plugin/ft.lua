local helpers = require('fsouza.lib.nvim_helpers')

local M = {}

function M.handle()
  if vim.bo.filetype and vim.bo.filetype ~= '' then
    local status, ft_plugin = pcall(require, 'fsouza.plugin.ft.' .. vim.bo.filetype)
    if status then
      pcall(ft_plugin)
    end
  end
end

function M.setup()
  helpers.augroup('fsouza__ft', {
    {
      events = {'FileType'};
      targets = {'*'};
      command = [[lua require('fsouza.plugin.ft').handle()]];
    };
  })
end

return M
