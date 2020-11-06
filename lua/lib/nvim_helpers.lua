local fun = require('lib.fun_wrapper')

local api = vim.api
local nvim_buf_set_keymap = api.nvim_buf_set_keymap
local vcmd = vim.cmd
local vfn = vim.fn

local M = {}

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

  fun.iter(mappings):each(function(mode, rules)
    fun.iter(rules):each(function(m)
      fn(mode, m.lhs, m.rhs, m.opts or {})
    end)
  end)
end

function M.exec_cmds(cmd_list)
  vcmd(table.concat(cmd_list, '\n'))
end

function M.augroup(name, commands)
  vcmd('augroup ' .. name)
  vcmd('autocmd!')
  fun.iter(commands):each(function(c)
    vcmd(string.format('autocmd %s %s %s', table.concat(c.events, ','),
                       table.concat(c.targets, ','), c.command))
  end)
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

function M.rewrite_wrap(fn)
  local orig_lineno = vfn.line('.')
  local orig_colno = vfn.col('.')
  local orig_line = vfn.getline(orig_lineno)
  local orig_nlines = vfn.line('$')
  local view = vfn.winsaveview()

  fn()

  -- note: this isn't 100% correct, if the lines change below the current one,
  -- the position won't be the same, but this is optmistic: if the file was
  -- already formatted before, the lines below will mostly do the right thing.
  local line_offset = vfn.line('$') - orig_nlines
  local lineno = orig_lineno + line_offset
  local col_offset = string.len(vfn.getline(lineno)) - string.len(orig_line)
  view.lnum = lineno
  view.col = orig_colno + col_offset - 1
  vfn.winrestview(view)
end

return M
