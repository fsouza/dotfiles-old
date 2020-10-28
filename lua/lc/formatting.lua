local M = {}

local api = vim.api
local lsp = vim.lsp
local vcmd = vim.cmd
local vfn = vim.fn
local helpers = require('lib.nvim_helpers')

local fmt_clients = {}

local slow_formatters = {python = true}

local langservers_skip_set = {tsserver = true}

local should_skip_buffer = function(bufnr)
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local prefix = vfn.getcwd()
  if not vim.endswith(prefix, '/') then
    prefix = prefix .. '/'
  end
  return not vim.startswith(file_path, prefix)
end

local should_skip_server = function(server_name)
  return langservers_skip_set[server_name] ~= nil
end

function M.register_client(client, bufnr)
  if should_skip_buffer(bufnr) then
    return
  end

  if should_skip_server(client.name) then
    return
  end

  -- TODO(fsouza): support multiple formatters per buffer?
  fmt_clients[bufnr] = client

  local slow = slow_formatters[api.nvim_buf_get_option(bufnr, 'filetype')]
  if slow == true then
    helpers.augroup('lc_autofmt_' .. bufnr, {
      {
        events = {'BufWritePost'};
        targets = {'<buffer>'};
        command = string.format([[lua require('lc.formatting').autofmt_and_write(%d)]], bufnr);
      };
    })
  else
    helpers.augroup('lc_autofmt_' .. bufnr, {
      {
        events = {'BufWritePre'};
        targets = {'<buffer>'};
        command = string.format([[lua require('lc.formatting').autofmt(%d)]], bufnr);
      };
    })
  end

  api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>f',
                          helpers.cmd_map('lua require("lc.formatting").fmt()'), {silent = true})
end

local formatting_params = function(bufnr)
  local sts = api.nvim_buf_get_option(bufnr, 'softtabstop')
  local options = {
    tabSize = (sts > 0 and sts) or (sts < 0 and api.nvim_buf_get_option(bufnr, 'shiftwidth')) or
      api.nvim_buf_get_option(bufnr, 'tabstop');
    insertSpaces = api.nvim_buf_get_option(bufnr, 'expandtab');
  }
  return {textDocument = {uri = vim.uri_from_bufnr(bufnr)}; options = options}
end

local apply_edits = function(result, bufnr)
  local curbuf = api.nvim_get_current_buf()
  if curbuf ~= bufnr then
    return
  end

  helpers.rewrite_wrap(function()
    lsp.util.apply_text_edits(result, bufnr)
  end)
end

local fmt = function(bufnr, cb)
  local client = fmt_clients[bufnr]
  if not client then
    error(string.format('cannot format the buffer %d, no lsp client registered', bufnr))
  end

  local _, req_id = client.request('textDocument/formatting', formatting_params(bufnr), cb, bufnr)
  return req_id, function()
    client.cancel_request(req_id)
  end
end

function M.fmt()
  fmt(api.nvim_get_current_buf(), nil)
end

function M.fmt_sync(bufnr, timeout_ms)
  local result
  local _, cancel = fmt(bufnr, function(_, _, result_, _)
    result = result_
  end)

  vim.wait(timeout_ms or 200, function()
    return result ~= nil
  end, 10)

  if not result then
    cancel()
    return
  end
  apply_edits(result, bufnr)
end

function M.autofmt(bufnr)
  local enable, timeout_ms = require('lib.autofmt').config()
  if enable then
    pcall(function()
      M.fmt_sync(bufnr, timeout_ms)
    end)
  end
end

function M.autofmt_and_write(bufnr)
  local enable, _ = require('lib.autofmt').config()
  if not enable then
    return
  end
  fmt(bufnr, function(_, _, result, _)
    local curr_buf = api.nvim_get_current_buf()
    if curr_buf ~= bufnr or vfn.mode() ~= 'n' then
      return
    end
    if result and result ~= vim.NIL then
      apply_edits(result, bufnr)
      vcmd('noautocmd write')
    end
  end)
end

function M.reset()
  for bufnr, _ in pairs(fmt_clients) do
    helpers.augroup('lc_autofmt_' .. bufnr, {})
  end
  fmt_clients = {}
end

return M
