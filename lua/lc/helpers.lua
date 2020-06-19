local M = {}

local cmd = require('lib/cmd')

function M.interpreter_properties_from_virtualenv(virtual_env)
  local int_path = virtual_env .. 'bin/python'
  local props = {InterpreterPath = virtual_env .. 'bin/python'; UseDefaultDatabase = true}
  local cb = function(r)
    if r.exit_status ~= 0 then
      print(string.format('failed to detect python version in the virtualenv $%s: %s', virtual_env,
                          r.stderr))
      return
    end
    props.Version = r.stdout
  end
  cmd.run(props.InterpreterPath, {
    '-c'; 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}", end="")'
  }, nil, cb)
  vim.wait(200, function()
    return props.Version ~= nil
  end, 25)
  return props
end

return M
