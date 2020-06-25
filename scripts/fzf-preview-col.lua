#!/usr/bin/env lua

local pattern = '([^:]+):(%d+):(%d+):(.*)'
local _, _, filename, lnum, _, _ = string.find(arg[1], pattern)

if not filename then
  error('invalid parameter ' .. arg[1])
end

local max = function(x, y)
  if x > y then
    return x
  else
    return y
  end
end

local start_line = max(tonumber(lnum) - 5, 1)
local end_line = tonumber(lnum) + 100

os.execute(string.format('cat %s | sed -n %d,%dp', filename, start_line, end_line))
