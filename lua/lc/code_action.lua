local api = vim.api
local buf = require('vim.lsp.buf')
local util = require('vim.lsp.util')

local M = {actions = {}}

local handle_selection = function(index)
  local action_chosen = M.actions[index]
  if action_chosen.edit or type(action_chosen.command) == 'table' then
    if action_chosen.edit then
      util.apply_workspace_edit(action_chosen.edit)
    end
    if type(action_chosen.command) == 'table' then
      buf.execute_command(action_chosen.command)
    end
  else
    buf.execute_command(action_chosen)
  end
end

function M.handle_actions(actions)
  local lines = {}
  M.actions = actions
  for _, action in ipairs(actions) do
    table.insert(lines, action.title)
  end
  require('lib.popup_picker').open(lines, handle_selection)
end

local code_action_for_buf = function()
  local bufnr = api.nvim_get_current_buf()
  local context = {diagnostics = vim.lsp.diagnostic.get(bufnr)}
  local params = {textDocument = {uri = vim.uri_from_bufnr(bufnr)}; context = context}
  vim.lsp.buf_request(bufnr, 'textDocument/codeAction', params)
end

local code_action_for_line = function(cb)
  local context = {diagnostics = vim.lsp.diagnostic.get_line_diagnostics()}
  local params = util.make_range_params()
  params.context = context
  vim.lsp.buf_request(0, 'textDocument/codeAction', params, cb)
end

function M.code_action()
  code_action_for_line(function(_, _, actions)
    if not actions or vim.tbl_isempty(actions) then
      return code_action_for_buf()
    end

    M.handle_actions(actions)
  end)
end

return M
