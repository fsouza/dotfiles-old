local api = vim.api
local vfn = vim.fn
local buf = vim.lsp.buf

local util = require('vim.lsp.util')

local M = {}

function M.handle_actions(actions)
  local lines = {}
  for _, action in ipairs(actions) do
    table.insert(lines, action.title)
  end

  local handle_selection = function(index)
    local action_chosen = actions[index]
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

function M.visual_code_action()
  local start_pos = vfn.getpos([['<]])
  local end_pos = vfn.getpos([['>]])
  vim.lsp.buf.range_code_action(nil, {start_pos[2]; start_pos[3]}, {end_pos[2]; end_pos[3]})
end

return M
