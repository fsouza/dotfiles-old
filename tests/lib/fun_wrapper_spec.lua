describe('', function()
  local fun = require('lib.fun_wrapper')
  describe('table iterators', function()
    it('tbl_keys should create an iterator with the keys', function()
      local t = {key1 = 'value1'; key2 = 'value2'}
      local expected = {'key1'; 'key2'}
      local iter = fun.tbl_keys(t)

      assert.are.same(expected, iter:totable())
    end)

    it('tbl_keys should support nil table', function()
      local iter = fun.tbl_keys(nil)

      assert.are.same({}, iter:totable())
    end)

    it('tbl_values should create an iterator with the values', function()
      local t = {key1 = 'value1'; key2 = 'value2'}
      local expected = {'value1'; 'value2'}
      local iter = fun.tbl_values(t)

      assert.are.same(expected, iter:totable())
    end)

    it('tbl_values should support nil table', function()
      local iter = fun.tbl_values(nil)

      assert.are.same({}, iter:totable())
    end)

    it('tbl_kvs should create an iterator with a tuple-like table', function()
      local t = {key1 = 'value1'; key2 = 'value2'}
      local expected = {{'key1'; 'value1'}; {'key2'; 'value2'}}
      local iter = fun.tbl_kvs(t)

      assert.are.same(expected, iter:totable())
    end)

    it('tbl_kvs should support nil table', function()
      local iter = fun.tbl_kvs(nil)

      assert.are.same({}, iter:totable())
    end)
  end)
end)
