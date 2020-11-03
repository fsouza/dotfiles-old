local M = {}

local meta = {}
function meta:__index(key)
  return require('themes.' .. key)()
end

return setmetatable(M, meta)
