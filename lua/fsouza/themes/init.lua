local M = {}

local meta = {}
function meta:__index(key)
  if key == 'popup' then
    M[key] = require('fsouza.themes.popup')()
  else
    M[key] = require('fsouza.themes.none')()
  end
  return M[key]
end

return setmetatable(M, meta)
