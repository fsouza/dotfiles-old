local M = {}

local function format_items_for_fzf(items)
  local lines = {}
  for _, item in pairs(items) do
    table.insert(lines, string.format('%s:%d:%d:%s', item.filename, item.lnum, item.col, item.text))
  end
  return lines
end

local function fzf_symbol_callback(_, _, result, _, bufnr)
  if not result or vim.tbl_isempty(result) then return end

  local items = vim.lsp.util.symbols_to_items(result, bufnr)
  vim.api.nvim_call_function('fsouza#lc#Fzf', { format_items_for_fzf(items) })
end

M['textDocument/documentSymbol'] = fzf_symbol_callback

M['workspace/symbol'] = fzf_symbol_callback

M['textDocument/references'] = function(_, _, result)
  if not result then return end
  local items = vim.lsp.util.locations_to_items(result)
  vim.api.nvim_call_function('fsouza#lc#Fzf', { format_items_for_fzf(items) })
end

M['textDocument/hover'] = function(_, method, result)
  vim.lsp.util.focusable_float(method, function()
    if not (result and result.contents) then
      return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
      return
    end
    local bufnr, winnr = vim.lsp.util.fancy_floating_markdown(markdown_lines, {
      pad_left = 1; pad_right = 1;
    })
    vim.api.nvim_buf_set_option(bufnr, 'modifiable', false)
    vim.api.nvim_win_set_option(winnr, 'relativenumber', false)
    vim.lsp.util.close_preview_autocmd({'CursorMoved', 'BufHidden', 'InsertCharPre'}, winnr)
    return bufnr, winnr
  end)
end

return M
