local api = vim.api
local vfn = vim.fn
local helpers = require('fsouza.lib.nvim_helpers')

local M = {}

function M.run()
  local bufnr = vfn.expand('<abuf>')
  local bufname = api.nvim_buf_get_name(bufnr)
  local dir = vfn.fnamemodify(bufname, ':h')
  vfn.mkdir(dir, 'p')
end

function M.setup()
  helpers.augroup('fsouza__mkdir', {
    {
      events = {'BufWritePre'};
      targets = {'*'};
      command = [[lua require('fsouza.plugin.mkdir').run()]];
    };
  })
end

return M
