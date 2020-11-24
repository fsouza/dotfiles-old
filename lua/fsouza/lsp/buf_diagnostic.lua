local api = vim.api

local M = {}

local debouncers = {}

local hooks = {}

function M.buf_clear_all_diagnostics()
  for _, bufnr in ipairs(api.nvim_list_bufs()) do
    vim.lsp.diagnostic.clear(bufnr)
  end
end

-- This is a workaround because the nvim-lsp doesn't let us hook into
-- textDocument/didChange like coc.nvim does.
local exec_hooks = function()
  for _, fn in pairs(hooks) do
    fn()
  end
end

local make_handler = function()
  local lsp_diagnostic = vim.lsp.diagnostic
  local handler = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true;
    virtual_text = true;
    signs = true;
    update_in_insert = true;
  })
  return function(err, method, result, client_id, bufnr)
    vim.schedule(exec_hooks)
    lsp_diagnostic.clear(bufnr, client_id)
    return handler(err, method, result, client_id)
  end
end

function M.register_hook(id, fn)
  hooks[id] = fn
end

function M.unregister_hook(id)
  hooks[id] = nil
end

function M.publish_diagnostics(err, method, result, client_id)
  if not result then
    return
  end
  local uri = result.uri
  local bufnr = vim.uri_to_bufnr(uri)
  if not bufnr then
    return
  end
  local debouncer_key = string.format('%d/%s', client_id, uri)
  local _handler = make_handler()
  local handler = debouncers[debouncer_key]

  if handler == nil then
    local interval = vim.b.lsp_diagnostic_debouncing_ms or 250
    handler = require('fsouza.lib.debounce').debounce(interval, vim.schedule_wrap(_handler))
    debouncers[debouncer_key] = handler
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function(_)
        handler.stop()
        debouncers[debouncer_key] = nil
      end;
    })
  end

  handler.call(err, method, result, client_id, bufnr)
end

return M
