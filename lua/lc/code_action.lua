local api = vim.api
local vfn = vim.fn
local buf = require('vim.lsp.buf')
local util = require('vim.lsp.util')
local helpers = require('lib.nvim_helpers')

local M = {actions = {}}

local win_var_identifier = 'fsouza__code_action'

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

local close_others = function()
  for _, winid in ipairs(api.nvim_list_wins()) do
    if pcall(api.nvim_win_get_var, winid, win_var_identifier) then
      api.nvim_win_close(winid, true)
    end
  end
end

function M.handle_actions(actions)
  local lines = {}
  M.actions = actions
  local longest = 0
  for _, action in ipairs(actions) do
    table.insert(lines, action.title)
    if #action.title > longest then
      longest = #action.title
    end
  end
  longest = longest * 2
  local min_width = 50
  local max_width = 3 * min_width
  local bufnr = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  local win_opts = {
    relative = 'cursor';
    width = min(max(longest, min_width), max_width);
    height = #lines;
    col = 0;
    row = 1;
    style = 'minimal';
  }
  close_others()
  local win_id = api.nvim_open_win(bufnr, true, win_opts)
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.cursorline = true
  vim.wo.number = true
  vim.wo.wrap = false
  vim.w[win_var_identifier] = true
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
