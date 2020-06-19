autocmd BufWritePre *.lua lua require('plugin/format').auto('lua_autoformat', require('plugin/format').lua)
