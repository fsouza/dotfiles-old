local vcmd = vim.cmd

local helpers = require('lib.nvim_helpers')

local M = {}

local keys = {'cterm'; 'ctermbg'; 'ctermfg'; 'gui'; 'guibg'; 'guifg'}

local _highlight_cmd = function(group, opts)
  local cmd_args = {group}
  for _, k in pairs(keys) do
    table.insert(cmd_args, string.format('%s=%s', k, opts[k] or 'NONE'))
  end
  return 'highlight ' .. table.concat(cmd_args, ' ')
end

local highlight = function(group, opts)
  vcmd(_highlight_cmd(group, opts))
end

local always_highlight = function(augroup, group, opts)
  local h_cmd = _highlight_cmd(group, opts)
  vcmd(h_cmd)
  helpers.augroup(augroup, {{events = {'ColorScheme'}; targets = {'*'}; command = h_cmd}})
end

local basics = function()
  highlight('CursorLine', {ctermbg = '253'; guibg = '#dadada'})
  highlight('CursorLineNr', {cterm = 'bold'; ctermbg = '253'; gui = 'bold'; guibg = '#dadada'})
  highlight('Directory', {ctermfg = '59'; guifg = '#5f5f5f'})
  highlight('LineNr', {ctermbg = '253'; guibg = '#dadada'})
  highlight('MatchParen', {ctermbg = '145'; guibg = '#afafaf'})
  highlight('Normal', {ctermfg = '235'; guifg = '#262626'})
  highlight('Floating', {ctermfg = '235'; guibg = '#f0f0f0'; guifg = '#262626'})
  highlight('Pmenu', {ctermbg = '145'; guibg = '#afafaf'})
  highlight('SignColumn', {ctermbg = '253'; ctermfg = '232'; guibg = '#dadada'; guifg = '#080808'})
  highlight('SpecialKey', {ctermfg = '59'; guifg = '#5f5f5f'})
  highlight('SpellBad', {ctermfg = '196'; guifg = '#ff0000'})
  highlight('TabLine', {ctermbg = '145'; ctermfg = '59'; guibg = '#afafaf'; guifg = '#5f5f5f'})
  highlight('TabLineFill', {ctermbg = '145'; guibg = '#afafaf'})
  highlight('TabLineSel', {ctermfg = '59'; guifg = '#5f5f5f'})
  highlight('Title', {})
  highlight('ModeMsg', {})
  highlight('ErrorMsg', {ctermbg = '160'; ctermfg = '231'; guibg = '#d70000'; guifg = '#ffffff'})
  highlight('WarningMsg', {cterm = 'None'; ctermfg = '52'; guifg = '#5f0000'})
  highlight('Folded', {ctermbg = '253'; guibg = '#dadada'})
  highlight('FoldColumn', {ctermbg = '253'; guibg = '#dadada'})
  highlight('Error', {ctermfg = '88'; guifg = '#990000'})
end

local noners = function()
  local noners = {
    'Boolean'; 'Character'; 'Comment'; 'Conceal'; 'Conditional'; 'Constant'; 'Debug'; 'Define';
    'Delimiter'; 'Exception'; 'Float'; 'Function'; 'Identifier'; 'Ignore'; 'Include'; 'Keyword';
    'Label'; 'Macro'; 'NonText'; 'Number'; 'Operator'; 'PmenuSbar'; 'PmenuSel'; 'PmenuThumb';
    'Question'; 'Search'; 'PreCondit'; 'PreProc'; 'Repeat'; 'Special'; 'SpecialChar';
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

local setup_lsp_reference = function(opts)
  for _, ref_type in pairs({'Text'; 'Read'; 'Write'}) do
    always_highlight(string.format('lsp_reference_%s_au', ref_type), 'LspReference' .. ref_type,
                     opts)
  end
  always_highlight('TSDefinitionUsage_au', 'TSDefinitionUsage', opts)
  always_highlight('TSDefinition_au', 'TSDefinition', opts)
end

local setup_lsp_diagnostics = function()
  local diagnostics = {guifg = '#a8a8a8'; ctermfg = '248'}
  local diagnostics_sign = {guifg = '#262626'; ctermfg = '235'; guibg = '#dadada'; ctermbg = '253'}

  for _, level in pairs({''; 'Error'; 'Warning'; 'Information'; 'Hint'}) do
    local base_group = 'LspDiagnostics' .. level
    local sign_group = base_group .. 'Sign'
    always_highlight(base_group .. '_au', base_group, diagnostics)
    always_highlight(sign_group .. '_au', sign_group, diagnostics_sign)
  end
end

local language_highlights = function()
  setup_lsp_diagnostics()
  setup_lsp_reference({guibg = '#d0d0d0'; ctermbg = '252'})
end

local custom_groups = function()
  always_highlight('hlhyank_highlight', 'HlYank', {ctermbg = '225'; guibg = '#ffd7ff'})
end

local setup_common = function()
  vim.o.background = 'light'
  vcmd('highlight clear')
  vcmd('syntax reset')
end

function M.setup_none()
  setup_common()
  vim.g.colors_name = 'none'

  basics()
  noners()
  reversers()
  language_highlights()
  custom_groups()
end

function M.customize_paper_color()
  highlight('Normal', {})
  highlight('NonText', {})
  highlight('CursorLineNr', {cterm = 'bold'; ctermbg = '253'; gui = 'bold'; guibg = '#dadada'})
  highlight('LineNr', {ctermbg = '253'; guibg = '#dadada'})
end

function M.setup()
  helpers.augroup('none_colorscheme', {
    {events = {'ColorScheme'}; targets = {'none'}; command = [[lua require('color').setup_none()]]};
  })
  helpers.augroup('papercolor_customizations', {
    {
      events = {'ColorScheme'};
      targets = {'PaperColor'};
      command = [[lua require('color').customize_paper_color()]];
    };
  })
  vcmd([[color none]])
end

return M
