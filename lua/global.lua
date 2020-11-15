local api = vim.api
local vfn = vim.fn

local M = {}

local key_for_comp_info = function(comp_info)
  if comp_info.mode == '' then
    return [[<cr>]]
  end
  if comp_info.pum_visible == 1 and comp_info.selected == -1 then
    return [[<c-e><cr>]]
  end
  return [[<cr>]]
end

function M.cr()
  local r = key_for_comp_info(vfn.complete_info())
  return api.nvim_replace_termcodes(r, true, false, true)
end

local trigger_completion = vim.fn['completion#trigger_completion']
local helpers = require('lib.nvim_helpers')

function M.complete()
  vim.g.completion_enable_auto_popup = 1
  helpers.augroup('nvim_complete_switch_off', {
    {
      events = {'InsertLeave'};
      targets = {'<buffer>'};
      command = [[let g:completion_enable_auto_popup = 0]];
    };
  })
  return trigger_completion()
end

return M
