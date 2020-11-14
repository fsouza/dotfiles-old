local api = vim.api
local helpers = require('lib.nvim_helpers')

local M = {}

local clients_by_buf = {}

local read_buffer = function(bufnr)
  local lines = table.concat(api.nvim_buf_get_lines(bufnr, 0, -1, true), '\n')
  if api.nvim_buf_get_option(bufnr, 'eol') then
    lines = lines .. '\n'
  end
  return lines
end

function M.notify(bufnr)
  if not clients_by_buf[bufnr] then
    return
  end

  local uri = vim.uri_from_bufnr(bufnr)
  local params = {
    textDocument = {uri = uri; version = api.nvim_buf_get_var(bufnr, 'changedtick')};
    contentChanges = {{text = read_buffer(bufnr)}};
  }
  for _, client in ipairs(clients_by_buf[bufnr]) do
    client.notify('textDocument/didChange', params)
  end
end

local buf_attach_if_needed = function(bufnr)
  if clients_by_buf[bufnr] then
    return
  end

  api.nvim_buf_attach(bufnr, false, {
    on_detach = function(_)
      clients_by_buf[bufnr] = nil
    end;
  })
end

function M.on_attach(opts)
  local bufnr = opts.bufnr
  buf_attach_if_needed(bufnr)
  clients_by_buf[bufnr] = clients_by_buf[bufnr] or {}
  table.insert(clients_by_buf[bufnr], opts.client)

  helpers.augroup('lc_shell_post_' .. bufnr, {
    {
      events = {'FileChangedShellPost'};
      targets = {string.format('<buffer=%d>', bufnr)};
      command = string.format([[lua require('lc.shell_post').notify(%d)]], bufnr);
    };
  })
end

return M
