local M = {}

local api = vim.api
local vfn = vim.fn
local lsp = vim.lsp

local fzf_symbol_callback = function(_, _, result, _, bufnr)
  if not result or vim.tbl_isempty(result) then
    return
  end

  local items = lsp.util.symbols_to_items(result, bufnr)
  require('lc.fzf').send(items, 'Symbols')
end

local set_popup_for_method = function(method)
  for _, window in ipairs(vfn.getwininfo()) do
    if window.variables[method] then
      require('color').set_popup_winid(window.winid)
      return
    end
  end
end

M['textDocument/documentSymbol'] = fzf_symbol_callback

M['workspace/symbol'] = fzf_symbol_callback

local function fzf_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end

  if vim.tbl_islist(result) then
    if #result > 1 then
      local items = lsp.util.locations_to_items(result)
      require('lc.fzf').send(items, 'Locations')
    else
      lsp.util.jump_to_location(result[1])
    end
  else
    lsp.util.jump_to_location(result)
  end
end

M['textDocument/declaration'] = fzf_location_callback
M['textDocument/definition'] = fzf_location_callback
M['textDocument/typeDefinition'] = fzf_location_callback
M['textDocument/implementation'] = fzf_location_callback

M['textDocument/references'] = function(_, _, result)
  if not result then
    return
  end
  local items = lsp.util.locations_to_items(result)
  require('lc.fzf').send(items, 'References')
end

M['textDocument/hover'] = function(_, method, result)
  if not result or not result.contents then
    return
  end
  lsp.util.focusable_float(method, function()
    local markdown_lines = lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
      return
    end
    local bufnr, winid = lsp.util.fancy_floating_markdown(markdown_lines,
                                                          {pad_left = 1; pad_right = 1})
    api.nvim_buf_set_option(bufnr, 'readonly', true)
    api.nvim_buf_set_option(bufnr, 'modifiable', false)
    api.nvim_win_set_option(winid, 'relativenumber', false)
    lsp.util.close_preview_autocmd({'CursorMoved'; 'BufHidden'; 'InsertCharPre'}, winid)
    return bufnr, winid
  end)
  set_popup_for_method(method)
end

M['textDocument/documentHighlight'] = function(_, _, result, _)
  if not result then
    return
  end
  local bufnr = api.nvim_get_current_buf()
  lsp.util.buf_clear_references(bufnr)
  lsp.util.buf_highlight_references(bufnr, result)
end

M['textDocument/publishDiagnostics'] = function(err, method, result, client_id)
  require('lc.buf_diagnostic').publishDiagnostics(err, method, result, client_id)
end

M['textDocument/codeAction'] = function(_, _, actions)
  if not actions or vim.tbl_isempty(actions) then
    return
  end
  require('lc.code_action').handle_actions(actions)
end

M['textDocument/signatureHelp'] = function(err, method, result)
  vim.lsp.callbacks[method](err, method, result)
  set_popup_for_method(method)
end

return M
