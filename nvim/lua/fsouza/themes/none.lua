local api = vim.api
local nvim_set_hl = api.nvim_set_hl

local colors = require('fsouza.themes.colors')

local function basics(ns)
  nvim_set_hl(ns, 'CursorColumn', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'CursorLine', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'CursorLineNr', {bold = true; bg = colors.lighter_gray})
  nvim_set_hl(ns, 'Directory', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'LineNr', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'MatchParen', {bg = colors.light_gray})
  nvim_set_hl(ns, 'Normal', {fg = colors.black})
  nvim_set_hl(ns, 'Floating', {bg = colors.light_gray; fg = colors.black})
  nvim_set_hl(ns, 'Pmenu', {bg = colors.gray})
  nvim_set_hl(ns, 'SignColumn', {bg = colors.lighter_gray; fg = colors.black})
  nvim_set_hl(ns, 'SpecialKey', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'SpellBad', {fg = colors.red})
  nvim_set_hl(ns, 'TabLine', {bg = colors.gray; fg = colors.dark_gray})
  nvim_set_hl(ns, 'TabLineFill', {bg = colors.gray})
  nvim_set_hl(ns, 'TabLineSel', {fg = colors.dark_gray})
  nvim_set_hl(ns, 'ErrorMsg', {bg = colors.red; fg = colors.white})
  nvim_set_hl(ns, 'WarningMsg', {fg = colors.brown})
  nvim_set_hl(ns, 'Folded', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'FoldColumn', {bg = colors.lighter_gray})
  nvim_set_hl(ns, 'Error', {fg = colors.red})
end

local function noners(ns)
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
    'Title';
    'ModeMsg';
  }
  for _, group in pairs(groups) do
    nvim_set_hl(ns, group, {})
  end
end

local function reversers(ns)
  local groups = {'MoreMsg'; 'StatusLine'; 'StatusLineNC'; 'Visual'};
  for _, group in pairs(groups) do
    nvim_set_hl(ns, group, {reverse = true})
  end
end

local function setup_lsp_reference(ns)
  for _, ref_type in pairs({'Text'; 'Read'; 'Write'}) do
    nvim_set_hl(ns, 'LspReference' .. ref_type, {bg = colors.light_gray})
  end
end

local function setup_lsp_diagnostics(ns)
  local diagnostics_floating = {fg = colors.black}
  local diagnostics_sign = {fg = colors.red; bg = colors.lighter_gray}

  for _, level in pairs({'Error'; 'Warning'; 'Information'; 'Hint'}) do
    local sign_group = 'LspDiagnosticsSign' .. level
    local floating_group = 'LspDiagnosticsFloating' .. level

    nvim_set_hl(ns, floating_group, diagnostics_floating)
    nvim_set_hl(ns, sign_group, diagnostics_sign)
  end
  nvim_set_hl(ns, 'User1', {bold = true; fg = colors.red})
end

local function setup_lsp_codelens(ns)
  nvim_set_hl(ns, 'LspCodeLensVirtualText', {fg = colors.gray})
end

local function language_highlights(ns)
  setup_lsp_diagnostics(ns)
  setup_lsp_reference(ns)
  setup_lsp_codelens(ns)
end

local function custom_groups(ns)
  nvim_set_hl(ns, 'HlYank', {bg = colors.orange})
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
