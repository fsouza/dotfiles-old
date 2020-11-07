local fun = require('lib.fun_wrapper')

local api = vim.api
local vfn = vim.fn
local buf = require('vim.lsp.buf')
local util = require('vim.lsp.util')
local helpers = require('lib.nvim_helpers')

local M = {actions = {}}

function M.handle_selection(win_id)
  local index = vfn.line('.')
  if index < 1 or index > #M.actions then
    return
  end
  api.nvim_win_close(win_id, false)
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

local max = function(x, y)
  if x > y then
    return x
  end
  return y
end

local min = function(x, y)
  if x < y then
    return x
  end
  return y
end

function M.handle_actions(actions)
  M.actions = actions
  local lines_iter = fun.safe_iter(actions):map(function(action)
    return action.title
  end)
  local width = lines_iter:map(function(line)
    return #line
  end):max() * 2
  local min_width = 50
  local max_width = 3 * min_width
  local lines = lines_iter:totable()
  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  local win_opts = {
    relative = 'cursor';
    width = max(min(width, max_width), min_width);
    height = #lines;
    col = 0;
    row = 1;
    style = 'minimal';
  }
  local win_id = api.nvim_open_win(bufnr, true, win_opts)
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.cursorline = true
  vim.wo.number = true
  vim.wo.wrap = false
  require('color').set_popup_winid(win_id)

  helpers.create_mappings({
    n = {
      {
        lhs = '<esc>';
        rhs = helpers.cmd_map(string.format([[lua vim.api.nvim_win_close(%d, false)]], win_id));
      };
      {
        lhs = '<cr>';
        rhs = helpers.cmd_map(string.format([[lua require('lc.code_action').handle_selection(%d)]],
                                            win_id));
      };
    };
  }, bufnr)
end

return M
