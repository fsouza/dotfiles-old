local api = vim.api
local vcmd = vim.cmd

local helpers = require('fsouza.lib.nvim_helpers')

local M = {}

local cbs = {}

function M.handle_selection(winid)
  local index = api.nvim_win_get_cursor(0)[1]
  local cb = cbs[winid]
  vim.schedule(function()
    vcmd([[wincmd p]])
    M.close(winid)
    cb(index)
  end)
end

function M.close(winid)
  cbs[winid] = nil
  api.nvim_win_close(winid, false)
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

local close_others = function(win_var_identifier)
  for _, winid in ipairs(api.nvim_list_wins()) do
    if pcall(api.nvim_win_get_var, winid, win_var_identifier) then
      api.nvim_win_close(winid, true)
    end
  end
  cbs = {}
end

function M.open(lines, cb)
  local longest = 0
  for _, line in ipairs(lines) do
    if #line > longest then
      longest = #line
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

  local win_var_identifier = 'fsouza__popup_picker'
  close_others(win_var_identifier)
  local winid = api.nvim_open_win(bufnr, true, win_opts)
  cbs[winid] = cb
  vim.bo.readonly = true
  vim.bo.modifiable = false
  vim.wo.cursorline = true
  vim.wo.number = true
  vim.wo.wrap = false
  vim.w[win_var_identifier] = true
  require('fsouza.color').set_popup_winid(winid)

  helpers.create_mappings({
    n = {
      {
        lhs = '<esc>';
        rhs = helpers.cmd_map(string.format([[lua require('fsouza.lib.popup_picker').close(%d)]],
                                            winid));
      };
      {
        lhs = '<cr>';
        rhs = helpers.cmd_map(string.format(
                                [[lua require('fsouza.lib.popup_picker').handle_selection(%d)]],
                                winid));
      };
    };
  }, bufnr)
end

return M
