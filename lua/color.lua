local nvim_command = vim.api.nvim_command
local nvim_set_option = vim.api.nvim_set_option

local keys = {'cterm'; 'ctermbg'; 'ctermfg'; 'gui'; 'guibg'; 'guifg'}

local highlight = function(group, opts)
  local cmd_args = {group}
  for _, k in pairs(keys) do
    table.insert(cmd_args, string.format('%s=%s', k, opts[k] or 'NONE'))
  end
  nvim_command('highlight ' .. table.concat(cmd_args, ' '))
end

local basics = function()
  highlight('CursorLine', {
    cterm = 'NONE';
    ctermbg = '253';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = '#dadada';
    guifg = 'NONE';
  })
  highlight('CursorLineNr', {
    cterm = 'bold';
    ctermbg = '253';
    ctermfg = 'NONE';
    gui = 'bold';
    guibg = '#dadada';
    guifg = 'NONE';
  })
  highlight('Directory', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = '59';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = '#5f5f5f';
  })
  highlight('LineNr', {
    cterm = 'NONE';
    ctermbg = '253';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = '#dadada';
    guifg = 'NONE';
  })
  highlight('MatchParen', {
    cterm = 'NONE';
    ctermbg = '145';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = '#afafaf';
    guifg = 'NONE';
  })
  highlight('Normal', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = '235';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = '#262626';
  })
  highlight('Pmenu', {
    cterm = 'NONE';
    ctermbg = '145';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = '#afafaf';
    guifg = 'NONE';
  })
  highlight('SignColumn', {
    cterm = 'NONE';
    ctermbg = '253';
    ctermfg = '232';
    gui = 'NONE';
    guibg = '#dadada';
    guifg = '#080808';
  })
  highlight('SpecialKey', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = '59';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = '#5f5f5f';
  })
  highlight('SpellBad', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = '196';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = '#ff0000';
  })
  highlight('TabLine', {
    cterm = 'NONE';
    ctermbg = '145';
    ctermfg = '59';
    gui = 'NONE';
    guibg = '#afafaf';
    guifg = '#5f5f5f';
  })
  highlight('TabLineFill', {
    cterm = 'NONE';
    ctermbg = '145';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = '#afafaf';
    guifg = 'NONE';
  })
  highlight('TabLineSel', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = '59';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = '#5f5f5f';
  })
  highlight('Title', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = 'NONE';
  })
  highlight('ModeMsg', {
    cterm = 'NONE';
    ctermbg = 'NONE';
    ctermfg = 'NONE';
    gui = 'NONE';
    guibg = 'NONE';
    guifg = 'NONE';
  })
  highlight('ErrorMsg', {
    cterm = 'NONE';
    ctermbg = '160';
    ctermfg = '231';
    gui = 'NONE';
    guibg = '#d70000';
    guifg = '#ffffff';
  })
  highlight('WarningMsg', {
    cterm = 'None';
    ctermbg = 'NONE';
    ctermfg = '52';
    gui = 'None';
    guibg = 'NONE';
    guifg = '#5f0000';
  })
end

local noners = function()
  local noners = {
    'Boolean'; 'Character'; 'Comment'; 'Conceal'; 'Conditional'; 'Constant'; 'Debug'; 'Define';
    'Delimiter'; 'Error'; 'Exception'; 'Float'; 'Function'; 'Identifier'; 'Ignore'; 'Include';
    'Keyword'; 'Label'; 'Macro'; 'NonText'; 'Number'; 'Operator'; 'PmenuSbar'; 'PmenuSel';
    'PmenuThumb'; 'Question'; 'Search'; 'PreCondit'; 'PreProc'; 'Repeat'; 'Special'; 'SpecialChar';
    'SpecialComment'; 'Statement'; 'StorageClass'; 'String'; 'Structure'; 'Tag'; 'Todo'; 'Type';
    'Typedef'; 'Underlined'; 'htmlBold';
  }
  for _, group in pairs(noners) do
    highlight(group, {})
  end
end

local reversers = function()
  local reversers = {'MoreMsg'; 'StatusLine'; 'StatusLineNC'; 'Visual'};
  for _, group in pairs(reversers) do
    highlight(group, {cterm = 'reverse'; gui = 'reverse'})
  end
end

local lsp_highlights = function()
  local diagnostics = {guifg = '#a8a8a8'; ctermfg = '248'}
  local diagnostics_sign = {guifg = '#262626'; ctermfg = '235'; guibg = '#dadada'; ctermbg = '253'}

  for _, level in pairs({'Error'; 'Warning'; 'Information'; 'Hint'}) do
    local base_group = 'LspDiagnostics' .. level
    local sign_group = base_group .. 'Sign'
    highlight(base_group, diagnostics)
    highlight(sign_group, diagnostics_sign)
  end

  local reference = {guibg = '#d0d0d0'; ctermbg = '252'}
  for _, ref_type in pairs({'Text'; 'Read'; 'Write'}) do
    highlight('LspReference' .. ref_type, reference)
  end
end

local custom_groups = function()
  highlight('HlYank', {ctermbg = '225'; guibg = '#ffd7ff'})
  highlight('BadWhitespace', {ctermbg = '160'; guibg = '#d70000'})
end

do
  nvim_set_option('background', 'light')
  nvim_command('highlight clear')
  nvim_command('syntax reset')
  vim.g.colors_name = 'none'

  basics()
  noners()
  reversers()
  lsp_highlights()
  custom_groups()
end
