-- Module with functions to be called from Vim on events, mappings or commands.
local M = {}

local api = vim.api
local lsp = vim.lsp

-- TODO: nvim-lsp will eventually support this, so once the pending PR is
-- merged, we should delete this code.
--
-- PR in neovim: https://github.com/neovim/neovim/pull/12378
local formatting_params = function(options)
  local sts = vim.bo.softtabstop
  options = vim.tbl_extend('keep', options or {}, {
    tabSize = (sts > 0 and sts) or (sts < 0 and vim.bo.shiftwidth) or vim.bo.tabstop;
    insertSpaces = vim.bo.expandtab
  })
  return {textDocument = {uri = vim.uri_from_bufnr(0)}; options = options}
end

local formatting_sync = function(options, timeout_ms)
  local params = formatting_params(options)
  local result = lsp.buf_request_sync(0, 'textDocument/formatting', params, timeout_ms)
  if not result then
    return
  end
  if not result[1] then
    return
  end
  result = result[1].result
  lsp.util.apply_text_edits(result)
end

function M.show_line_diagnostics()
  local prefix = '- '
  local indent = '  '
  local lines = {'Diagnostics:'; ''}
  local line_diagnostics = lsp.util.get_line_diagnostics()
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  for _, diagnostic in pairs(line_diagnostics) do
    local message_lines = vim.split(diagnostic.message, '\n', true)
    table.insert(lines, prefix .. message_lines[1])
    for j = 2, #message_lines do
      table.insert(lines, indent .. message_lines[j])
    end
  end
  return lsp.util.open_floating_preview(lines, 'plaintext')
end

function M.auto_format()
  local g = vim.g.LC_autoformat
  local b = vim.b.LC_autoformat
  local timeout_ms = vim.b.LC_autoformat_timeout_ms or 500

  if g ~= false and b ~= false then
    formatting_sync({timeout_ms = timeout_ms})
  end
end

function M.list_file_diagnostics()
  local fname = vim.fn.expand('%')
  local bufnr = api.nvim_get_current_buf()
  local diagnostics = lsp.util.diagnostics_by_buf[bufnr]
  if not diagnostics then
    return
  end

  local items = {}
  for _, diagnostic in ipairs(diagnostics) do
    local pos = diagnostic.range.start
    table.insert(items, {
      filename = fname;
      lnum = pos.line;
      col = pos.character;
      text = diagnostic.message
    })
  end
  lsp.util.set_qflist(items)
  api.nvim_command('copen')
  api.nvim_command('wincmd p')
  api.nvim_command('cc')
end

return M
