local M = {}

local loop = vim.loop

local input_collector = function(stream_handle)
  local result = {data = ''}
  function result.callback(err, chunk)
    if err then
      result.err = err
    elseif chunk then
      result.data = result.data .. chunk
    end
  end
  return result
end

-- run takes the given command, args and input_data (used as stdin for the
-- child process).
--
-- The last parameter is a callback that will be invoked whenever the command
-- finishes, the callback receives a table in the following shape:
--
-- {
--   stdout: string;
--   stderr: string;
--   exit_status: number;
--   signal: number;
--   errors: string table;
-- }
--
-- The function returns a function that can be called to wait for the command
-- to finish. The function takes a timeout and returns the same values as
-- vim.wait.
function M.run(cmd, args, input_data, on_finished)
  local cmd_handle
  local stdout = loop.new_pipe(false)
  local stderr = loop.new_pipe(false)
  local stdin = loop.new_pipe(false)

  local close = function()
    loop.read_stop(stdout)
    loop.read_stop(stderr)
    loop.close(stdout)
    loop.close(stderr)
    loop.close(stdin)
    loop.close(cmd_handle)
  end

  local stdout_handler = input_collector(stdout)
  local stderr_handler = input_collector(stderr)

  local r = {abort = false; finished = false}
  local onexit = function(code, signal)
    if r.abort and code == 0 then
      code = -1
    end
    vim.schedule(function()
      local errors = {}
      if stdout_handler.err then
        table.insert(errors, stdout_handler.err)
      end
      if stderr_handler.err then
        table.insert(errors, stderr_handler.err)
      end

      on_finished({
        exit_status = code;
        aborted = abort;
        signal = signal;
        stdout = stdout_handler.data;
        stderr = stderr_handler.data;
        errors = errors
      })
      r.finished = true
    end)
  end

  cmd_handle = loop.spawn(cmd, {args = args; stdio = {stdin; stdout; stderr}}, onexit)

  loop.read_start(stdout, stdout_handler.callback)
  loop.read_start(stderr, stderr_handler.callback)

  if input_data then
    loop.write(stdin, input_data)
  end
  loop.shutdown(stdin)

  return function(timeout_ms)
    local status, code = vim.wait(timeout_ms, function()
      return r.finished
    end, 100)

    if not status then
      r.abort = true
      loop.close(cmd_handle, close)
    end

    return status, code
  end
end

return M
