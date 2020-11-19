local vcmd = vim.cmd
local api = vim.api
local nvim_buf_get_option = api.nvim_buf_get_option
local nvim_buf_set_option = api.nvim_buf_set_option
local cmd = require('fsouza.lib.cmd')
local helpers = require('fsouza.lib.nvim_helpers')

local M = {}

local set_enabled = function(v)
  local commands = {}
  if v then
    table.insert(commands, {
      events = {'BufNewFile'; 'BufReadPost'; 'BufFilePost'};
      targets = {'*'};
      command = [[lua require('fsouza.plugin.editor_config').set_config()]];
    });
  end
  helpers.augroup('editorconfig', commands)
  M.set_config()
end

local parse_output = function(data)
  local lines = vim.split(data, '\n')
  local opts = {}
  for _, line in ipairs(lines) do
    local parts = vim.split(line, '=')
    if #parts == 2 then
      opts[parts[1]] = parts[2]
    end
  end
  return opts
end

local get_vim_fenc = function(editorconfig_charset)
  if editorconfig_charset == 'utf-8' or editorconfig_charset == 'latin1' then
    return editorconfig_charset, false
  elseif editorconfig_charset == 'utf-16be' or editorconfig_charset == 'utf-16le' then
    return editorconfig_charset, true
  else
    return 'utf-8', true
  end
end

local get_vim_fileformat = function(editorconfig_eol)
  local m = {crlf = 'dos'; cr = 'mac'}
  return m[editorconfig_eol] or 'unix'
end

local handle_whitespaces = function(bufnr, v)
  local commands = {}
  if v == 'true' then
    table.insert(commands, {
      events = {'BufWritePre'};
      targets = {'<buffer>'};
      command = [[lua require('fsouza.plugin.editor_config').trim_whitespace()]];
    })
  end
  helpers.augroup('editorconfig_trim_trailing_whitespace_' .. bufnr, commands)
end

local set_opts = function(bufnr, opts)
  local vim_opts = {}
  for k, v in pairs(opts) do
    if k == 'charset' then
      vim_opts.fileencoding, vim_opts.bomb = get_vim_fenc(v)
    end

    if k == 'end_of_line' then
      vim_opts.fileformat = get_vim_fileformat(v)
    end

    if k == 'indent_style' then
      vim_opts.expandtab = v == 'spaces' or v == 'space'
    end

    if k == 'insert_final_line' or k == 'insert_final_newline' then
      vim_opts.fixendofline = v == 'true'
    end

    if k == 'indent_size' then
      local indent_size = tonumber(v)
      vim_opts.shiftwidth = indent_size
      vim_opts.softtabstop = indent_size
    end

    if k == 'tab_width' then
      vim_opts.tabstop = tonumber(v)
    end

    if k == 'trim_trailing_whitespace' then
      vim.schedule(function()
        handle_whitespaces(bufnr, v)
      end)
    end
  end

  vim.schedule(function()
    if nvim_buf_get_option(bufnr, 'modifiable') then
      for k, v in pairs(vim_opts) do
        nvim_buf_set_option(bufnr, k, v)
      end
    end
  end)
end

function M.enable()
  set_enabled(true)
end

function M.disable()
  set_enabled(false)
end

function M.set_config()
  if not vim.bo.modifiable then
    return
  end
  local bufnr = api.nvim_get_current_buf()
  local filename = api.nvim_buf_get_name(bufnr)
  if filename == '' then
    return
  end

  cmd.run('editorconfig', {args = {filename}}, nil, function(result)
    if result.exit_status ~= 0 then
      error(string.format('failed to run editorconfig: %d - %s', result.exit_status, result.stderr))
    end

    local opts = parse_output(result.stdout)
    set_opts(bufnr, opts)
  end)
end

function M.trim_whitespace()
  pcall(function()
    vcmd([[silent! keeppatterns %s/\s\+$//e]])
  end)
end

return M
