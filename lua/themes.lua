local M = {}

local meta = {}
function meta:__index(key)
  if key == 'popup' then
    M[key] = require('themes.popup')()
  else
    M[key] = require('themes.none')()
  end
  return M[key]
end

return setmetatable(M, meta)
