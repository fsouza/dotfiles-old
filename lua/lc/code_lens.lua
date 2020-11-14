local api = vim.api
local helpers = require('lib.nvim_helpers')

local M = {}

local debouncers = {}

local clients = {}

-- stores result by bufnr & line (range.start.line)
local code_lenses = {}

local group_by_line = function(codelenses)
  local by_line = {}
  for _, codelens in ipairs(codelenses) do
    local line_id = codelens.range.start.line
    local curr = by_line[line_id] or {}
    table.insert(curr, codelens)
    by_line[line_id] = curr
  end
  return by_line
end

local remove_results = function(bufnr)
  code_lenses[bufnr] = nil
end

local codelenses_handler = function(_, _, codelenses, _, bufnr)
  if not codelenses then
    return
  end

  local grouped = group_by_line(codelenses)
  code_lenses[bufnr] = grouped
  local ns = api.nvim_create_namespace('fsouza__code_lens')
  api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local prefix = ' '
  for line, items in pairs(grouped) do
    local titles = {}
    for _, item in ipairs(items) do
      table.insert(titles, item.command.title)
    end
    local chunks = {
      {string.format('%s%s', prefix, table.concat(titles, ' | ')); 'LspCodeLensVirtualText'};
    }
    api.nvim_buf_set_virtual_text(bufnr, ns, line, chunks, {})
  end
end

local codelenses = function(bufnr)
  if not clients[bufnr] then
    return
  end
  if bufnr == 0 then
    bufnr = api.nvim_get_current_buf()
  end
  local params = {textDocument = {uri = vim.uri_from_bufnr(bufnr)}}
  clients[bufnr].lsp_client.request('textDocument/codeLens', params, codelenses_handler, bufnr)
end

function M.codelens(bufnr)
  local debouncer_key = bufnr
  local debounced = debouncers[debouncer_key]
  if debounced == nil then
    local interval = vim.b.lsp_codelens_debouncing_ms or 50
    debounced = require('lib.debounce').debounce(interval, vim.schedule_wrap(codelenses))
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

local resolve_handler = function(err)
  if err then
    error('failed to resolve codelens: ' .. err)
  end
end

local execute_codelenses = function(bufnr, items)
  if vim.tbl_isempty(items) then
    return
  end

  local client = clients[bufnr]
  if not client then
    return
  end

  local execute_item = function(selected)
    if client.supports_resolve then
      client.lsp_client.request('codeLens/resolve', selected, resolve_handler, bufnr)
    elseif client.supports_command then
      client.lsp_client.request('workspace/executeCommand', selected.command)
    end
  end

  if #items > 1 then
    local popup_lines = {}
    for _, item in ipairs(items) do
      table.insert(popup_lines, item.command.title)
    end
    require('lib.popup_picker').open(popup_lines, function(index)
      execute_item(items[index])
    end)
  else
    execute_item(items[1])
  end
end

function M.execute()
  local winid = api.nvim_get_current_win()
  local bufnr = api.nvim_win_get_buf(winid)
  local cursor = api.nvim_win_get_cursor(winid)
  local line_id = cursor[1] - 1
  local buffer_results = code_lenses[bufnr]
  if not buffer_results then
    return
  end
  local line_codelenses = buffer_results[line_id]
  if not line_codelenses then
    return
  end
  execute_codelenses(bufnr, line_codelenses)
end

function M.on_attach(opts)
  local bufnr = opts.bufnr
  local client = opts.client
  clients[bufnr] = {
    lsp_client = client;
    supports_resolve = opts.can_resolve;
    supports_command = opts.supports_command;
  }
  vim.schedule(function()
    M.codelens(bufnr)
  end)

  local augroup_id = 'lsp_codelens_' .. bufnr
  helpers.augroup(augroup_id, {
    {
      events = {'InsertLeave'; 'BufWritePost'};
      targets = {string.format('<buffer=%d>', bufnr)};
      command = string.format([[lua require('lc.code_lens').codelens(%d)]], bufnr);
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
        remove_results(bufnr)
        clients[bufnr] = nil
      end;
    })
  end)

  if opts.mapping then
    helpers.create_mappings({
      n = {
        {
          lhs = opts.mapping;
          rhs = helpers.cmd_map([[lua require('lc.code_lens').execute()]]);
          {silent = true};
        };
      };
    }, bufnr)
  end
end

return M
