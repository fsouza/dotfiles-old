local fun = require('lib.fun_wrapper')

local M = {}

local api = vim.api
local lsp = vim.lsp
local vcmd = vim.cmd
local vfn = vim.fn

function M.show_line_diagnostics()
  local indent = '  '
  local line_diagnostics = lsp.util.get_line_diagnostics()
  if vim.tbl_isempty(line_diagnostics) then
    return
  end

  local prefix = fun.safe_iter({'Diagnostics:'; ''})
  local diagnostic_messages = fun.safe_iter(line_diagnostics):map(
                                function(diagnostic)
      local hd, tl = fun.split_str(diagnostic.message, '\n'):span(1)
      return hd:map(function(line)
        return string.format('- [%s] %s', diagnostic.source, line)
      end):chain(tl:map(function(line)
        return indent .. line
      end))
    end)
  local bufnr, winid = lsp.util.open_floating_preview(
                         prefix:chain(fun.flatten(diagnostic_messages)):totable(), 'plaintext')
  require('color').set_popup_winid(winid)
  return bufnr, winid
end

local items_from_diagnostics = function(bufnr, diagnostics)
  local fname = vfn.bufname(bufnr)
  return fun.safe_iter(diagnostics):map(function(diagnostic)
    local pos = diagnostic.range.start
    return {
      filename = fname;
      lnum = pos.line + 1;
      col = pos.character + 1;
      text = diagnostic.message;
    }
  end)
end

local render_diagnostics = function(items)
  lsp.util.set_qflist(items:totable())
  if items:is_null() then
    vcmd('cclose')
  else
    vcmd('copen')
    vcmd('wincmd p')
    vcmd('cc')
  end
end

function M.list_file_diagnostics()
  local bufnr = api.nvim_get_current_buf()
  local diagnostics = lsp.util.diagnostics_by_buf[bufnr]
  if not diagnostics then
    return
  end

  local items = items_from_diagnostics(bufnr, diagnostics)
  render_diagnostics(items)
end

function M.list_workspace_diagnostics()
  local items = fun.tbl_kvs(lsp.utils.diagnostics_by_buf):map(
                  function(kv)
      return items_from_diagnostics(kv[1], kv[2])
    end)
  render_diagnostics(fun.flatten(items))
end

return M
