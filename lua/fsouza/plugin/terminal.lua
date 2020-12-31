local api = vim.api
local vfn = vim.fn

local M = {}

-- reuse the filetype because I want to use the same settings for toggleterm
-- and don't want to create multiple ft modules to config such settings.
local filetype = 'toggleterm'

-- maps number to a terminal, where a terminal is a table with the following
-- shape: { bufnr: ..., job_id: ... }
local terminals = {}

local function set_options(bufnr)
  api.nvim_buf_set_option(bufnr, 'filetype', filetype)
  api.nvim_buf_set_option(bufnr, 'buflisted', false)
end

local function jump_to(bufnr)
  api.nvim_set_current_buf(bufnr)
end

local function create_terminal(term_id)
  local bufnr = api.nvim_create_buf(false, false)
  set_options(bufnr)
  jump_to(bufnr)
  local job_id = vfn.termopen(string.format('%s;#fsouza_term', vim.o.shell), {
    detach = false;
    on_exit = function()
      terminals[term_id] = nil
    end;
  })
  terminals[term_id] = {bufnr = bufnr; job_id = job_id}
  return terminals[term_id]
end

local function get_term(term_id)
  local term = terminals[term_id]
  if term and api.nvim_buf_is_valid(term.bufnr) then
    return term
  end
  terminals[term_id] = nil
  return nil
end

local function ensure_term(term_id)
  local term = get_term(term_id)
  if not term then
    return create_terminal(term_id)
  end
  return term
end

function M.open(term_id)
  local term = ensure_term(term_id)
  jump_to(term.bufnr)
end

function M.run(term_id, command)
  local term = ensure_term(term_id)
  if not vim.endswith(command, '\n') then
    command = command .. '\n'
  end
  vfn.chansend(term.job_id, command)
end

return M
