local api = vim.api
local vfn = vim.fn
local buf = require('vim.lsp.buf')
local util = require('vim.lsp.util')
local helpers = require('lib.nvim_helpers')

local M = {actions = {}}

function M.handle_selection(winnr)
  local index = vfn.line('.')
  if index < 1 or index > #M.actions then
    return
  end
  api.nvim_win_close(winnr, false)
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
  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  local win_opts = {
    relative = 'cursor';
    width = 50;
    height = #lines;
    col = 0;
    row = 1;
    style = 'minimal';
  }
  local winnr = api.nvim_open_win(bufnr, true, win_opts)
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.cursorline = true
  vim.wo.number = true
  vim.wo.wrap = false
  vim.wo.winhl =
    'Normal:LspActionsNormal,CursorLine:LspActionsCurrent,LineNr:LspActionsLineNr,CursorLineNr:LspActionsCurrent'

  helpers.create_mappings({
    n = {
      {
        lhs = '<esc>';
        rhs = helpers.cmd_map(string.format([[lua vim.api.nvim_win_close(%d, false)]], winnr));
      }; {
        lhs = '<cr>';
        rhs = helpers.cmd_map(string.format([[lua require('lc.code_action').handle_selection(%d)]],
                                            winnr));
      };
    };
  }, bufnr)
end

return M
