local trigger_completion = vim.fn['completion#trigger_completion']
local helpers = require('fsouza.lib.nvim_helpers')

return function()
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
