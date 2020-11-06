local fun = require('fun')
local api = vim.api
local nvim_set_hl = api.nvim_set_hl

local colors = require('themes.colors')

local basics = function(ns)
  nvim_set_hl(ns, 'CursorColumn', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'CursorLine', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'CursorLineNr', {bold = true; bg = colors.lighter_gray})
  nvim_set_hl(ns, 'Directory', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'LineNr', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'MatchParen', {bg = colors.gray})
  nvim_set_hl(ns, 'Normal', {fg = colors.black})
  nvim_set_hl(ns, 'Floating', {bg = colors.light_gray; fg = colors.black})
  nvim_set_hl(ns, 'Pmenu', {bg = colors.gray})
  nvim_set_hl(ns, 'SignColumn', {bg = colors.lighter_gray; fg = colors.black})
  nvim_set_hl(ns, 'SpecialKey', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'SpellBad', {fg = colors.red})
  nvim_set_hl(ns, 'TabLine', {bg = colors.gray; fg = colors.dark_gray})
  nvim_set_hl(ns, 'TabLineFill', {bg = colors.gray})
  nvim_set_hl(ns, 'TabLineSel', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'Title', {})
  nvim_set_hl(ns, 'ModeMsg', {})
  nvim_set_hl(ns, 'ErrorMsg', {bg = colors.red; fg = colors.white})
  nvim_set_hl(ns, 'WarningMsg', {fg = colors.brown})
  nvim_set_hl(ns, 'Folded', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'FoldColumn', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'Error', {fg = colors.red})
end

local noners = function(ns)
  local groups = {
    'Boolean';
    'Character';
    'Comment';
    'Conceal';
    'Conditional';
    'Constant';
    'Debug';
    'Define';
    'Delimiter';
    'Exception';
    'Float';
    'Function';
    'Identifier';
    'Ignore';
    'Include';
    'Keyword';
    'Label';
    'Macro';
    'NonText';
    'Number';
    'Operator';
    'PmenuSbar';
    'PmenuSel';
    'PmenuThumb';
    'Question';
    'Search';
    'PreCondit';
    'PreProc';
    'Repeat';
    'Special';
    'SpecialChar';
    'SpecialComment';
    'Statement';
    'StorageClass';
    'String';
    'Structure';
    'Tag';
    'Todo';
    'Type';
    'Typedef';
    'Underlined';
    'htmlBold';
  }
  fun.iter(groups):each(function(g)
    nvim_set_hl(ns, g, {})
  end)
end

local reversers = function(ns)
  local groups = {'MoreMsg'; 'StatusLine'; 'StatusLineNC'; 'Visual'};
  fun.iter(groups):each(function(g)
    nvim_set_hl(ns, g, {reverse = true})
  end)
end

local setup_lsp_reference = function(ns, hl_opts)
  fun.iter({'Text'; 'Read'; 'Write'}):each(function(ref_type)
    nvim_set_hl(ns, 'LspReference' .. ref_type, hl_opts)
  end)
end

local setup_lsp_diagnostics = function(ns)
  local diagnostics = {fg = colors.gray}
  local diagnostics_sign = {link = 'SignColumn'}

  fun.iter({''; 'Error'; 'Warning'; 'Information'; 'Hint'}):each(
    function(level)
      local base_group = 'LspDiagnostics' .. level
      local sign_group = base_group .. 'Sign'
      nvim_set_hl(ns, base_group, diagnostics)
      nvim_set_hl(ns, sign_group, diagnostics_sign)
    end)
end

local language_highlights = function(ns)
  setup_lsp_diagnostics(ns)
  setup_lsp_reference(ns, {bg = colors.light_gray})
end

local custom_groups = function(ns)
  nvim_set_hl(ns, 'HlYank', {bg = colors.pink})
end

return function(name)
  name = name or 'fsouza__none'
  local ns = api.nvim_create_namespace(name)
  basics(ns)
  noners(ns)
  reversers(ns)
  language_highlights(ns)
  custom_groups(ns)
  return ns
end
