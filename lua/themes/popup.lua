local nvim_set_hl = vim.api.nvim_set_hl

local colors = require('themes.colors')

return function()
  local theme = require('color.none')('fsouza__popup')
  nvim_set_hl(theme, 'Normal', colors.gray)
  return theme
end
