local M = {}

local api = vim.api
local lsp = vim.lsp
local vcmd = vim.cmd
local vfn = vim.fn
local helpers = require('lib.nvim_helpers')

local fmt_clients = {}

local slow_formatters = {python = true; fsharp = true}

local should_skip_server = function(server_name)
  local skip_set = {tsserver = true}
  return skip_set[server_name] ~= nil
end

function M.register_client(client, bufnr)
  if should_skip_server(client.name) then
    return
  end

  for _, filetype in pairs(client.config.filetypes) do
    fmt_clients[filetype] = client
  end

  local slow = slow_formatters[api.nvim_buf_get_option(bufnr, 'filetype')]
  if slow == true then
    helpers.augroup('lc_autofmt_' .. bufnr, {
      {
        events = {'BufWritePost'};
        targets = {'<buffer>'};
        command = [[lua require('lc.formatting').autofmt_and_write()]];
      };
    })
  else
    helpers.augroup('lc_autofmt_' .. bufnr, {
      {
        events = {'BufWritePre'};
        targets = {'<buffer>'};
        command = [[lua require('lc.formatting').autofmt()]];
      };
    })
  end

  api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>f',
                          helpers.cmd_map('lua require("lc.formatting").fmt()'), {silent = true})
  api.nvim_buf_set_keymap(bufnr, 'n', '<localleader>w',
                          helpers.cmd_map([[lua require('lc.formatting').autofmt_and_write()]]),
                          {silent = true})
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
  -- sanity check. I could switch to bufnr, apply the changes and come back,
  -- but that would be a weird experience.
  local curbuf = api.nvim_get_current_buf()
  if curbuf ~= bufnr then
    return
  end

  helpers.rewrite_wrap(function()
    lsp.util.apply_text_edits(result, bufnr)
  end)
end

local fmt = function(bufnr, cb)
  local client = fmt_clients[vim.bo.filetype]
  if not client then
    error(string.format('cannot format %s files, no lsp client registered', vim.bo.filetype))
  end

  local _, req_id = client.request('textDocument/formatting', formatting_params(bufnr), cb, bufnr)
  return req_id, function()
    client.cancel_request(req_id)
  end
end

function M.fmt()
  fmt(api.nvim_get_current_buf(), nil)
end

function M.fmt_sync(timeout_ms)
  local bufnr = api.nvim_get_current_buf()
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

function M.autofmt()
  local enable, timeout_ms = require('lib.autofmt').config()
  if enable then
    pcall(function()
      M.fmt_sync(timeout_ms)
    end)
  end
end

function M.autofmt_and_write()
  local enable, _ = require('lib.autofmt').config()
  if not enable then
    return
  end
  local bufnr = api.nvim_get_current_buf()
  fmt(bufnr, function(_, _, result, _)
    if vfn.mode() ~= 'n' then
      return
    end
    if result then
      apply_edits(result, bufnr)
    end
    local curr_bufnr = api.nvim_get_current_buf()
    vcmd(string.format('%dbufdo noautocmd write', bufnr))
    if curr_bufnr ~= bufnr then
      vcmd(string.format('buffer %d', curr_bufnr))
    end
  end)
end

return M
