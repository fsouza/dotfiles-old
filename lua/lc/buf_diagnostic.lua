local highlight = require('vim.highlight')
local fun = require('lib.fun_wrapper')

local M = {}

local api = vim.api
local vfn = vim.fn
local util = vim.lsp.util
local protocol = vim.lsp.protocol

-- table of tables of iterators, indexed by buffer and client_id, respectively.
--
-- Example:
--
-- { [1] = { [5] = <iterator> } }
--
-- This has diagnostics provided by client_id 5 in buffer 1.
local diagnostics_by_buf = {}

local underline_highlight_name = 'LspDiagnosticsUnderline'

local sign_namespaces = {}

local diagnostic_namespaces = {}

local debouncers = {}

local sign_ns = function(client_id)
  if sign_namespaces[client_id] == nil then
    sign_namespaces[client_id] = string.format('lsp-sign-%d', client_id)
  end
  return sign_namespaces[client_id]
end

local diagnostic_ns = function(client_id)
  if diagnostic_namespaces[client_id] == nil then
    diagnostic_namespaces[client_id] = api.nvim_create_namespace(
                                         string.format('lsp-diagnostic-%d', client_id))
  end
  return diagnostic_namespaces[client_id]
end

local save_all_positions = function(bufnr, client_id, diagnostics)
  if not diagnostics_by_buf[bufnr] then
    diagnostics_by_buf[bufnr] = {}
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function(b)
        diagnostics_by_buf[b] = nil
      end;
    })
  end
  diagnostics_by_buf[bufnr][client_id] = diagnostics

  local buf_diagnostics = fun.flatten(fun.tbl_values(diagnostics_by_buf[bufnr]))
  util.buf_diagnostics_save_positions(bufnr, buf_diagnostics:totable())
end

local buf_clear_diagnostics = function(bufnr, client_id)
  vim.fn.sign_unplace(sign_ns(client_id), {buffer = bufnr})
  api.nvim_buf_clear_namespace(bufnr, diagnostic_ns(client_id), 0, -1)
  save_all_positions(bufnr, client_id, fun.safe_iter({}))
end

local buf_diagnostics_underline = function(bufnr, client_id, diagnostics)
  diagnostics:each(function(diagnostic)
    local start = diagnostic.range['start']
    local finish = diagnostic.range['end']

    local hlmap = {
      [protocol.DiagnosticSeverity.Error] = 'Error';
      [protocol.DiagnosticSeverity.Warning] = 'Warning';
      [protocol.DiagnosticSeverity.Information] = 'Information';
      [protocol.DiagnosticSeverity.Hint] = 'Hint';
    }

    highlight.range(bufnr, diagnostic_ns(client_id),
                    underline_highlight_name .. hlmap[diagnostic.severity],
                    {start.line; start.character}, {finish.line; finish.character})
  end)
end

local buf_diagnostics_virtual_text = function(bufnr, client_id, diagnostics)
  local buffer_line_diagnostics = util.diagnostics_group_by_line(diagnostics:totable())
  fun.tbl_kvs(buffer_line_diagnostics):each(function(kv)
    local line, line_diags = kv[1], kv[2]
    local virt_texts = fun.safe_iter(line_diags):drop_n(1):map(
                         function()
        return {'■'; 'LspDiagnostics'}
      end):totable()
    local last = line_diags[#line_diags]
    table.insert(virt_texts, {
      string.format('■ [%s] %s', last.source, last.message:gsub('\r', ''):gsub('\n', '  '));
      'LspDiagnostics';
    })
    api.nvim_buf_set_virtual_text(bufnr, diagnostic_ns(client_id), line, virt_texts, {})
  end)
end

local buf_diagnostics_signs = function(bufnr, client_id, diagnostics)
  local diagnostic_severity_map = {
    [protocol.DiagnosticSeverity.Error] = 'LspDiagnosticsErrorSign';
    [protocol.DiagnosticSeverity.Warning] = 'LspDiagnosticsWarningSign';
    [protocol.DiagnosticSeverity.Information] = 'LspDiagnosticsInformationSign';
    [protocol.DiagnosticSeverity.Hint] = 'LspDiagnosticsHintSign';
  }

  diagnostics:each(function(diagnostic)
    vim.fn.sign_place(0, sign_ns(client_id), diagnostic_severity_map[diagnostic.severity], bufnr,
                      {lnum = (diagnostic.range.start.line + 1)})
  end)
end

function M.buf_clear_diagnostics()
  local d_ns = fun.tbl_values(diagnostic_namespaces)
  local s_ns = fun.tbl_values(sign_namespaces)
  fun.safe_iter(vfn.getbufinfo()):each(function(buffer)
    local bufnr = buffer.bufnr
    d_ns:each(function(ns)
      api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    end)
    s_ns:each(function(ns)
      vim.fn.sign_unplace(ns, {buffer = bufnr})
    end)
    util.buf_diagnostics_save_positions(bufnr, {})
  end)
  diagnostic_namespaces = {}
  sign_namespaces = {}
end

local handle_publish = function(bufnr, client_id, result)
  buf_clear_diagnostics(bufnr, client_id)
  local diagnostics = fun.safe_iter(result.diagnostics):map(
                        function(diagnostic)
      if diagnostic.severity == nil then
        diagnostic.severity = protocol.DiagnosticSeverity.Error
      end
      fun.tbl_values(sign_namespaces)
      return diagnostic
    end)

  save_all_positions(bufnr, client_id, diagnostics)
  if not api.nvim_buf_is_loaded(bufnr) then
    return
  end
  buf_diagnostics_underline(bufnr, client_id, diagnostics)
  buf_diagnostics_virtual_text(bufnr, client_id, diagnostics)
  buf_diagnostics_signs(bufnr, client_id, diagnostics)
  vim.cmd('doautocmd User LspDiagnosticsChanged')
end

function M.publishDiagnostics(_, _, result, client_id)
  if not result then
    return
  end
  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then
    return
  end
  local debouncer_key = string.format('%d/%s', client_id, uri)

  local handler = debouncers[debouncer_key]
  if handler == nil then
    local interval = vim.b.lsp_diagnostic_debouncing_ms or 250
    handler = require('lib.debounce').debounce(interval, vim.schedule_wrap(handle_publish))
    debouncers[debouncer_key] = handler
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function(_)
        debouncers[debouncer_key] = nil
      end;
    })
  end

  handler.call(bufnr, client_id, result)
end

return M
