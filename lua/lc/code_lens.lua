local api = vim.api
local helpers = require('lib.nvim_helpers')

local M = {}

local debouncers = {}

local clients = {}

local codelens_handler = function(_, _, result, bufnr)
  if not result or vim.tbl_isempty(result) then
    return
  end
  local ns = api.nvim_create_namespace('fsouza__code_lens')
  api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local prefix = ' '
  for _, cl in ipairs(result) do
    if cl.command.command == '' then
      local chunks = {{string.format('%s%s', prefix, cl.command.title); 'LspCodeLensVirtualText'}}
      api.nvim_buf_set_virtual_text(bufnr, ns, cl.range.start.line, chunks, {})
    end
  end
end

-- TODO(fsouza): implement codeLens/resolve.
--
-- When doing that, remove the if above, and also cache the results of
-- textDocument/codeLens (by buffer + line, so we can look it up in o(1).
function M.resolve()
end

local codelens = function(bufnr)
  if not clients[bufnr] then
    return
  end
  if bufnr == 0 then
    bufnr = api.nvim_get_current_buf()
  end
  local params = {textDocument = {uri = vim.uri_from_bufnr(bufnr)}}
  clients[bufnr].request('textDocument/codeLens', params, function(err, method, result)
    codelens_handler(err, method, result, bufnr)
  end, bufnr)
end

function M.codelens(bufnr)
  local debouncer_key = tostring(bufnr)
  local debounced = debouncers[debouncer_key]
  if debounced == nil then
    local interval = vim.b.lsp_codelens_debouncing_ms or 50
    debounced = require('lib.debounce').debounce(interval, vim.schedule_wrap(codelens))
    debouncers[debouncer_key] = debounced
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function()
        debounced.stop()
        debouncers[debouncer_key] = nil
      end;
    })
  end
  debounced.call(bufnr)
end

function M.on_attach(opts)
  local bufnr = opts.bufnr
  local client = opts.client
  clients[bufnr] = client
  vim.schedule(function()
    M.codelens(bufnr)
  end)

  local augroup_id = 'lsp_codelens_' .. bufnr
  local command = string.format([[lua require('lc.code_lens').codelens(%d)]], bufnr)
  helpers.augroup(augroup_id, {
    {
      events = {'InsertLeave'; 'BufWritePost'};
      targets = {string.format('<buffer=%d>', bufnr)};
      command = command;
    };
  })

  vim.schedule(function()
    local hook_id = augroup_id
    require('lc.buf_diagnostic').register_hook(hook_id, function()
      M.codelens(bufnr)
    end)
    api.nvim_buf_attach(bufnr, false, {
      on_detach = function()
        helpers.augroup(augroup_id, {})
        require('lc.buf_diagnostic').unregister_hook(hook_id)
        clients[bufnr] = nil
      end;
    })
  end)
end

return M
