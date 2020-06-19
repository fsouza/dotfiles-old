autocmd BufWritePre *.lua lua require('plugin/format').auto('dune_autoformat', require('plugin/format').dune)
