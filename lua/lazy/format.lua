local M = {}

local input_collector = function(stream_handle)
  local result = {data = ''}
  function result.callback(_, chunk)
    if (chunk) then
      result.data = result.data .. chunk
    end
  end
  return result
end

-- TODO(fsouza): make this less messy and support async formatting.
local format_stdin = function(gate_var, format_cmd, format_args, timeout_ms)
  timeout_ms = timeout_ms or 2000
  local bufnr = vim.api.nvim_get_current_buf()

  local var = vim.b[gate_var]
  if var == nil then
    local g_var = vim.g[gate_var]
    var = g_var == nil and true or g_var
  end
  if var then
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local r = {}
    local handle
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local stdin = vim.loop.new_pipe(false)
    local close = function()
      vim.loop.read_stop(stdout)
      vim.loop.read_stop(stderr)
      vim.loop.close(stdout)
      vim.loop.close(stderr)
      vim.loop.close(handle)
    end

    handle = vim.loop.spawn(format_cmd,
                            {args = format_args; stdio = {stdin; stdout; stderr}},
                            function(code, signal)
      r.code = code
      r.signal = signal
      close()
    end)

    local stdout_handler = input_collector(stdout)
    local stderr_handler = input_collector(stderr)

    vim.loop.read_start(stdout, stdout_handler.callback)
    vim.loop.read_start(stderr, stderr_handler.callback)

    for _, line in ipairs(lines) do
      vim.loop.write(stdin, line .. '\n')
    end
    vim.loop.close(stdin)

    local status = vim.wait(timeout_ms, function()
      return r.code ~= nil
    end)
    if not status then
      error(string.format('%s did not complete in %dms, consider increasing the timeout',
                          format_cmd, timeout_ms))
      vim.loop.close(handle, close)
    end

    if r.code ~= 0 then
      error(string.format('%s exited with status code %d: %s', format_cmd, r.code,
                          stderr_handler.data))
    end

    local new_lines = vim.split(stdout_handler.data, '\n')
    while new_lines[#new_lines] == '' do
      table.remove(new_lines, #new_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
  end
end

function M.dune()
  format_stdin('dune_autoformat', 'dune', {'format-dune-file'})
end

function M.prettier()
  format_stdin('Prettier_autoformat', 'npx',
               {'prettier'; '--stdin-filepath'; vim.fn.expand('%p')})
end

function M.lua_format()
  format_stdin('lua_autoformat', 'lua-format', {})
end

return M
