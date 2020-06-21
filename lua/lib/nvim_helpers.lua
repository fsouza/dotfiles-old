local M = {}

local api = vim.api
local nvim_buf_set_keymap = api.nvim_buf_set_keymap
local nvim_command = api.nvim_command

function M.cmd_map(cmd)
  return string.format('<cmd>%s<cr>', cmd)
end

function M.create_mappings(mappings, bufnr)
  local fn = api.nvim_set_keymap
  if bufnr then
    fn = function(...)
      nvim_buf_set_keymap(bufnr, ...)
    end
  end

  for mode, rules in pairs(mappings) do
    for _, m in ipairs(rules) do
      fn(mode, m.lhs, m.rhs, m.opts or {})
    end
  end
end

function M.exec_cmds(cmd_list)
  nvim_command(table.concat(cmd_list, '\n'))
end

return M
