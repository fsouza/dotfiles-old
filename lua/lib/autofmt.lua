local vfn = vim.fn

local M = {}

-- returns the autofmt configuration in a tuple (<enabled>, <timeout_ms).
--
-- For enabled, we first look at vim.b, then vim.g (and it defaults to true).
function M.config(bufnr)
  local timeout_ms = vim.b.autoformat_timeout_ms or 500
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  local prefix = vfn.getcwd()
  if not vim.endswith(prefix, '/') then
    prefix = prefix .. '/'
  end
  if not vim.startswith(file_path, prefix) then
    return false, timeout_ms
  end
  if vim.b.autoformat ~= nil then
    return vim.b.autoformat, timeout_ms
  end
  if vim.g.autoformat ~= nil then
    return vim.g.autoformat, timeout_ms
  end
  return true, timeout_ms
end

local toggle = function(ns)
  if ns.autoformat == false then
    ns.autoformat = true
  else
    ns.autoformat = false
  end
end

function M.toggle()
  toggle(vim.b)
end

function M.toggle_g()
  toggle(vim.g)
end

return M
