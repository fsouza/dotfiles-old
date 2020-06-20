local cmd = require('lib/cmd')

-- run the given commands and block until all of them are done. it raises an
-- error if any of the command fails, with information about the failure (exit
-- status + stderr).
--
-- The input is a table of commands, where each command is a table in the following format:
--
-- {
--    executable: string;
--    opts: table; (note: this should match vim.loop.spawn options, see lib/cmd.lua for details)
--    timeout_ms: number; (defaults to 10 minutes)
-- }
local run_cmds = function(cmds)
  local ten_minutes_ms = 1000 * 60 * 10
  local results = {}
  local total_timeout_ms = 0

  for i, c in pairs(cmds) do
    local idx = i
    local timeout_ms = c.timeout_ms or ten_minutes_ms
    if timeout_ms > total_timeout_ms then
      total_timeout_ms = timeout_ms
    end

    table.insert(results, nil)
    local block = cmd.run(c.executable, c.opts, nil, function(result)
      results[idx] = result
    end)
    vim.schedule(function ()
      block(timeout_ms)
    end)
  end

  local status = vim.wait(total_timeout_ms, function ()
    for _, r in pairs(results) do
      if r == nil then
        return false
      end
    end
    return true
  end, 20)

  if not status then
    error(string.format('failed to complete all commands in %dms', total_timeout_ms))
  end
end
