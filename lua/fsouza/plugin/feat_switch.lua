local M = {}

local enable_lsp = function()
  require('fsouza.lsp').setup()
end

local enable_ts = function()
  require('fsouza.plugin.ts').setup()
end

local trigger_ft = function()
  if vim.bo.filetype and vim.bo.filetype ~= '' then
    vim.cmd([[doautocmd FileType ]] .. vim.bo.filetype)
  end
end

function M.enable_lsp_ts()
  enable_lsp()
  enable_ts()
  vim.schedule(trigger_ft)
end

return M
