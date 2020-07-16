local M = {}

local api = vim.api
local nvim_buf_set_keymap = api.nvim_buf_set_keymap
local vcmd = vim.cmd

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
  vcmd(table.concat(cmd_list, '\n'))
end

function M.augroup(name, commands)
  vcmd('augroup ' .. name)
  vcmd('autocmd!')
  for _, c in ipairs(commands) do
    vcmd(string.format('autocmd %s %s %s', table.concat(c.events, ','),
                       table.concat(c.targets, ','), c.command))
  end
  vcmd('augroup END')
end

function M.ensure_path_relative_to_prefix(prefix, path)
  if not vim.endswith(prefix, '/') then
    prefix = prefix .. '/'
  end
  if vim.startswith(path, prefix) then
    return string.sub(path, string.len(prefix) + 1)
  end
  return path
end

return M
