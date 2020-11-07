local M = {}

local meta = {}
function meta:__index(key)
  M[key] = require('themes.' .. key)()
  return M[key]
end

return setmetatable(M, meta)
