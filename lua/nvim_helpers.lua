local M = {}

function M.cmd_map(cmd)
  return string.format('<cmd>%s<cr>', cmd)
end

function M.create_mappings(mappings, bufnr)
  local fn = vim.api.nvim_set_keymap
  if bufnr then
    fn = function(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
  end

  for mode, rules in pairs(mappings) do
    for lhs, opts in pairs(rules) do
      local rhs = opts[1]
      local opts = opts[2] or {}
      fn(mode, lhs, rhs, opts)
    end
  end
end

function M.exec_cmds(cmd_list)
  vim.api.nvim_command(table.concat(cmd_list, '\n'))
end

return M
