local M = {}

local meta = {}
function meta:__index(key) return require('global/' .. key) end

return setmetatable(M, meta)
