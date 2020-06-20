local M = {}

local lsp = vim.lsp
local util = require('vim.lsp.util')

local min = function(x, y)
  if x < y then
    return x
  else
    return y
  end
end

local preview_location_callback = function(_, _, result)
  print(vim.inspect(result))
  if not result or vim.tbl_isempty(result) then
    return
  end

  local loc = result[1]

  -- this is a hack
  local end_line = loc.range['end'].line
  loc.range['end'].line = end_line + 20
  util.preview_location(loc)
end

function M.preview_definition()
  local params = util.make_position_params()
  lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

function M.preview_declaration()
  local params = util.make_position_params()
  lsp.buf_request(0, 'textDocument/declaration', params, preview_location_callback)
end

function M.preview_implementation()
  local params = util.make_position_params()
  lsp.buf_request(0, 'textDocument/implementation', params, preview_location_callback)
end

return M
