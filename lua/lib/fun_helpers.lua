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
    return fun.iter(fn(t))
  end
end

local zero_range = function(n)
  if n > 0 then
    return fun.range(n)
  end
  return fun.iter({})
end

return {
  tbl_keys = make_iter(tbl_keys);
  tbl_values = make_iter(tbl_values);
  tbl_kvs = make_iter(tbl_kvs);
  range = zero_range;
}
