local M = {}

function M.cmd_map(cmd)
  return string.format('<cmd>%s<cr>', cmd)
end

function M.create_mappings(mappings)
  for kind, rules in pairs(mappings) do
    for lhs, opts in pairs(rules) do
      local rhs = opts[1]
      local opts = opts[2] or {}
      vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
    end
  end
end

return M
