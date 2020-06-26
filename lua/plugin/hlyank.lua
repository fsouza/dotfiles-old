local vfn = vim.fn

return {
  on_yank = function(...)
    if vfn.visualmode() ~= '' or vfn.reg_executing() ~= '' then
      return
    end
    require('vim.highlight').on_yank(...)
  end;
}
