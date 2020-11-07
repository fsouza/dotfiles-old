describe('fun_wrapper', function()
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

  describe('negate', function()
    it('negate should negate the result of a boolean function', function()
      local bool_function = function()
        return true
      end
      local orig = bool_function()
      local negated = fun.negate(bool_function)()
      local double_negated = fun.negate(fun.negate(bool_function))()

      assert.are.same(orig, double_negated)
      assert.are_not.same(orig, negated)
    end)
  end)

  describe('split_str', function()
    it('can split by spaces', function()
      local iter = fun.split_str('this is a test', ' ')

      assert.are.same({'this'; 'is'; 'a'; 'test'}, iter:totable())
    end)

    it('can split by newline', function()
      local iter = fun.split_str('this is a test\nwith\nmultiple lines\n', '\n')

      assert.are.same({'this is a test'; 'with'; 'multiple lines'}, iter:totable())
    end)

    it('can split by any character', function()
      local iter = fun.split_str('whats_this_madness', '_')

      assert.are.same({'whats'; 'this'; 'madness'}, iter:totable())
    end)

    it('can split with empty parts', function()
      local iter = fun.split_str('\n\n\n', '\n')

      assert.are.same({''; ''; ''}, iter:totable())
    end)

    it('can split empty string', function()
      local iter = fun.split_str('', '\n')

      assert.are.same({}, iter:totable())
    end)
  end)

  describe('safe_iter', function()
    it('wraps fun.safe_iter()', function()
      local iter = fun.safe_iter({1; 2; 3})

      assert.are.same({1; 2; 3}, iter:totable())
    end)

    it('accepts nil', function()
      local iter = fun.safe_iter()

      assert.are.same({}, iter:totable())
    end)
  end)
end)
