local api = vim.api
local vfn = vim.fn
local helpers = require('fsouza.lib.nvim_helpers')

local M = {}

function M.run(bufnr)
  local bufname = api.nvim_buf_get_name(bufnr)
  local dir = vfn.fnamemodify(bufname, ':h')
  vfn.mkdir(dir, 'p')
end

function M.register_for_buffer()
  local bufnr = vfn.expand('<abuf>')
  helpers.augroup('fsouza__mkdir_' .. bufnr, {
    {
      events = {'BufWritePre'};
      targets = {string.format('<buffer=%d>', bufnr)};
      modifiers = {'++once'};
      command = string.format([[lua require('fsouza.plugin.mkdir').run(%d)]], bufnr);
    };
  })
end

function M.setup()
  helpers.augroup('fsouza__mkdir', {
    {
      events = {'BufNew'};
      targets = {'*'};
      command = [[lua require('fsouza.plugin.mkdir').register_for_buffer()]];
    };
  })
end

return M
