local nvim_set_hl = vim.api.nvim_set_hl

local colors = require('fsouza.themes.colors')

return function(name)
  local theme = require('fsouza.themes.none')(name or 'fsouza__popup')
  nvim_set_hl(theme, 'Normal', {fg = colors.black; bg = colors.gray});
  nvim_set_hl(theme, 'LineNr', {})
  return theme
end
