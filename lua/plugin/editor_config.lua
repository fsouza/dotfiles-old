local fun = require('lib.fun_wrapper')

local vfn = vim.fn
local vcmd = vim.cmd
local api = vim.api
local nvim_buf_get_option = api.nvim_buf_get_option
local nvim_buf_set_option = api.nvim_buf_set_option
local cmd = require('lib.cmd')
local helpers = require('lib.nvim_helpers')

local M = {}

local set_enabled = function(v)
  local commands = {}
  if v then
    table.insert(commands, {
      events = {'BufNewFile'; 'BufReadPost'; 'BufFilePost'};
      targets = {'*'};
      command = [[lua require('plugin.editor_config').set_config()]];
    });
  end
  helpers.augroup('editorconfig', commands)
  M.set_config()
end

local parse_output = function(data)
  return fun.split_str(data, '\n'):map(function(line)
    return vim.split(line, '=')
  end):filter(function(parts)
    return #parts == 2
  end):map(function(parts)
    return parts[1], parts[2]
  end)
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
      command = [[lua require('plugin.editor_config').trim_whitespace()]];
    })
  end
  helpers.augroup('editorconfig_trim_trailing_whitespace_' .. bufnr, commands)
end

local set_opts = function(bufnr, opts)
  local vim_opts = opts:map(function(k, v)
    if k == 'charset' then
      local fenc, bomb = get_vim_fenc(v)
      return {{'fileencoding'; fenc}; {'bomb'; bomb}}
    end

    if k == 'end_of_line' then
      return {{'fileformat'; get_vim_fileformat(v)}}
    end

    if k == 'indent_style' then
      return {{'expandtab'; v == 'spaces' or v == 'space'}}
    end

    if k == 'insert_final_line' or k == 'insert_final_newline' then
      return {{'fixendofline'; v == 'true'}}
    end

    if k == 'indent_size' then
      -- indent_size can be set to 'tab', in which case we don't want to do
      -- anything.
      local indent_size = tonumber(v)
      if indent_size then
        return {{'shiftwidth'; indent_size}; {'softtabstop'; indent_size}}
      end
    end

    if k == 'tab_width' then
      return {{'tabstop'; tonumber(v)}}
    end

    -- side-effect alert :)
    if k == 'trim_trailing_whitespace' then
      vim.schedule(function()
        handle_whitespaces(bufnr, v)
      end)
    end

    return {}
  end):filter(fun.negate(vim.tbl_isempty)):map(fun.iter)

  vim.schedule(function()
    if nvim_buf_get_option(bufnr, 'modifiable') then
      fun.flatten(vim_opts):each(function(opt)
        nvim_buf_set_option(bufnr, opt[1], opt[2])
      end)
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
  local filename = vfn.expand('%:p')
  if filename == '' then
    return
  end
  local bufnr = vfn.bufnr(filename)

  cmd.run('editorconfig', {args = {filename}}, nil, function(result)
    if result.exit_status ~= 0 then
      error(string.format('failed to run editorconfig: %d - %s', result.exit_status, result.stderr))
    end

    local opts = parse_output(result.stdout)
    set_opts(bufnr, opts)
  end)
end

function M.trim_whitespace()
  local view = vfn.winsaveview()
  pcall(function()
    vcmd([[silent! keeppatterns %s/\s\+$//e]])
  end)
  vfn.winrestview(view)
end

return M
