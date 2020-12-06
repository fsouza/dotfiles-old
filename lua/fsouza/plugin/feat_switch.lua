local M = {}

local function enable_lsp()
  require('fsouza.lsp')
end

local function enable_ts()
  require('fsouza.plugin.ts')
end

local function trigger_ft()
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
