local M = {}

local vcmd = vim.cmd
local lsp = vim.lsp
local api = vim.api
local vfn = vim.fn
local loop = vim.loop
local helpers = require('lib.nvim_helpers')

local fzf_actions = {['ctrl-t'] = 'tabedit'; ['ctrl-x'] = 'split'; ['ctrl-v'] = 'vsplit'}

local lines_to_qf_list = function(lines)
  local items = {}
  for _, line in ipairs(lines) do
    local _, _, filename, lnum, col, text = string.find(line, [[([^:]+):(%d+):(%d+):(.*)]])
    if filename then
      table.insert(items,
                   {filename = filename; lnum = tonumber(lnum); col = tonumber(col); text = text})
    end
  end
  return items
end

local handle_lsp_lines = function(lines)
  if #lines < 2 then
    return
  end

  local first_line = table.remove(lines, 1)
  local action = fzf_actions[first_line] or 'edit'
  local qf_list = lines_to_qf_list(lines)
  if #qf_list < 1 then
    return
  end

  if #qf_list == 1 then
    local item = qf_list[1]
    vcmd(string.format('%s %s', action, item.filename))
    api.nvim_win_set_cursor(0, {item.lnum; item.col - 1})
    api.nvim_input('zvzz')
  else
    lsp.util.set_qflist(qf_list)
    vcmd('copen')
    vcmd('wincmd p')
    vcmd('cc')
  end
end

local format_items = function(items)
  local lines = {}
  local prefix = loop.cwd() .. '/'
  for _, item in pairs(items) do
    local filename = item.filename
    table.insert(lines,
                 string.format('%s:%d:%d:%s',
                               helpers.ensure_path_relative_to_prefix(prefix, filename), item.lnum,
                               item.col, item.text))
  end
  return lines
end

function M.send(items, prompt)
  require('plugin.fuzzy').ensure_fzf()
  prompt = prompt .. '：'
  local opts = {
    source = format_items(items);
    options = {
      '--expect';
      'ctrl-t,ctrl-x,ctrl-v';
      '--multi';
      '--bind';
      'ctrl-q:select-all';
      '--preview-window';
      '+{2}-5';
      '--delimiter';
      ':';
      '--prompt';
      prompt;
    };
  }
  opts = vfn['fzf#wrap'](vfn['fzf#vim#with_preview'](opts))
  opts['sink*'] = handle_lsp_lines
  vfn['fzf#run'](opts)
end

return M
