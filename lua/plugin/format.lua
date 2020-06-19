local M = {}

local format_stdin = function(format_cmd, format_args, timeout_ms)
  local bufnr = vim.api.nvim_get_current_buf()
  local view = vim.fn.winsaveview()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  local cmd = require('lib/cmd')
  local block = cmd.run(format_cmd, format_args, table.concat(lines, '\n'), function(r)
    if r.exit_status ~= 0 then
      error(string.format('%s exited with status code %d: %s', format_cmd, r.exit_status, r.stderr))
    end

    local new_lines = vim.split(r.stdout, '\n')
    while new_lines[#new_lines] == '' do
      table.remove(new_lines, #new_lines)
    end
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, new_lines)
    vim.fn.winrestview(view)
  end)

  if timeout_ms then
    local status = block(timeout_ms)
    if not status then
      error(string.format('%s did not complete in %dms, consider increasing the timeout',
                          format_cmd, timeout_ms))
    end
  end
end

function M.dune(timeout_ms)
  format_stdin('dune', {'format-dune-file'}, timeout_ms)
end

function M.prettier(timeout_ms)
  format_stdin('npx', {'prettier'; '--stdin-filepath'; vim.fn.expand('%p')}, timeout_ms)
end

function M.lua(timeout_ms)
  format_stdin('lua-format', {}, timeout_ms)
end

function M.auto(gate_var, fn)
  if vim.b[gate_var] == false or (vim.b[gate_var] == nil and vim.g[gate_var] == false) then
    return
  end
  fn(vim.b.autofmt_timeout_ms or vim.g.autofmt_timeout_ms or 2000)
end

return M
