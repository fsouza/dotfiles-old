-- Wrapper for the 'fun' library, with some utilities to make iterators and
-- table work better together.
local M = {}

local fun = require('fun')

local tbl_keys = function(tbl)
  return function(t, state)
    local k, v = next(t, state)
    if v ~= nil then
      return k, k
    end
  end, tbl, nil
end

local tbl_values = function(tbl)
  return function(t, state)
    local k, v = next(t, state)
    if v ~= nil then
      return k, v
    end
  end, tbl, nil
end

local tbl_kvs = function(tbl)
  return function(t, state)
    local k, v = next(t, state)
    if v ~= nil then
      return k, {k; v}
    end
  end, tbl, nil
end

local make_iter = function(fn)
  return function(t)
    t = t or {}
    return fun.iter(fn(t))
  end
end

M.tbl_keys = make_iter(tbl_keys)

M.tbl_values = make_iter(tbl_values)

M.tbl_kvs = make_iter(tbl_kvs)

function M.negate(fn)
  return function(v)
    return not fn(v)
  end
end

function M.split(iter, pred)
  local aux = function()
    return function(_, state)
      if state:is_null() then
        return
      end
      local value, new_state = state:span(pred)
      return new_state:drop_n(1), value
    end, nil, iter
  end
  return fun.iter(aux())
end

-- takes a string and a separatator, and returns a generator of strings
-- separated by `sep`.
--
-- Separator must be 1-char long.
function M.split_str(s, sep)
  return M.split(fun.iter(s), function(ch)
    return ch ~= sep
  end):map(function(seq)
    return seq:foldl(fun.operator.concat, '')
  end)
end

M.empty = fun.iter({})

-- TODO(fsouza): figure out what's up with internal state in fun (or how I'm
-- fucking this up).
--
-- This should be implementable with foldl like below:
--
-- function M.flatten(iter)
--   return iter:foldl(fun.chain, M.empty)
-- end
function M.flatten(iter)
  return fun.chain(unpack(iter:totable()))
end

function M.safe_iter(v)
  if not v then
    return M.empty
  end
  return fun.iter(v)
end

local meta = {}

function meta:__index(key)
  return fun[key]
end

return setmetatable(M, meta)
