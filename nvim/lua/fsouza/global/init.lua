local M = {}

local meta = {}
function meta:__index(key)
  M[key] = require('fsouza.global.' .. key)
  return M[key]
end

return setmetatable(M, meta)
