"Change file type for ruby
autocmd BufEnter Capfile set ft=ruby
autocmd FileType ruby set ft=ruby.ruby-rails.ruby-rspec.ruby-rails-rjs.ruby-shoulda

"Change tabs to 2 space on ruby files
autocmd BufEnter Capfile setlocal tabstop=2
autocmd BufEnter Capfile setlocal shiftwidth=2
autocmd BufEnter Capfile setlocal softtabstop=2
autocmd BufEnter *.rb setlocal tabstop=2
autocmd BufEnter *.rb setlocal shiftwidth=2
autocmd BufEnter *.rb setlocal softtabstop=2
