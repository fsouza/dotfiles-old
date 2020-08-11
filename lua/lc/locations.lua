local M = {}

local lsp = vim.lsp
local lsp_util = require('vim.lsp.util')

local peek_location_callback = function(_, _, result)
  if not result or vim.tbl_isempty(result) then
    return
  end
  lsp_util.preview_location(result[1])
end

function M.preview_definition()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/definition', params, peek_location_callback)
end

function M.preview_declaration()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/declaration', params, peek_location_callback)
end

function M.preview_implementation()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/implementation', params, peek_location_callback)
end

function M.preview_type_definition()
  local params = lsp_util.make_position_params()
  lsp.buf_request(0, 'textDocument/typeDefinition', params, peek_location_callback)
end

return M
