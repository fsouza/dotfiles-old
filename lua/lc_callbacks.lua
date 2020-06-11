local M = {}

M['textDocument/hover'] = function(_, method, result)
  vim.lsp.util.focusable_float(method, function()
    if not (result and result.contents) then
      return
    end
    local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
    markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
    if vim.tbl_isempty(markdown_lines) then
      -- return { 'No information available' }
      return
    end
    local bufnr, winnr = vim.lsp.util.fancy_floating_markdown(markdown_lines, {
      pad_left = 1; pad_right = 1;
    })
    local cwin = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(winnr)
    vim.cmd("setlocal nornu readonly")
    vim.api.nvim_set_current_win(cwin)
    vim.lsp.util.close_preview_autocmd({'CursorMoved', 'BufHidden', 'InsertCharPre'}, winnr)
    return bufnr, winnr
  end)
end

return M
