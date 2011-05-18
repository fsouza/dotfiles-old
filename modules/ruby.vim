"Change file type for ruby
autocmd FileType ruby set ft=ruby.ruby-rails.ruby-rspec.ruby-rails-rjs.ruby-shoulda

"Change tabs to 2 space on ruby files
autocmd BufEnter *.rb set tabstop=2
autocmd BufEnter *.rb set shiftwidth=2
autocmd BufEnter *.rb set softtabstop=2

"Undo the change
autocmd BufLeave *.rb set tabstop=4
autocmd BufLeave *.rb set shiftwidth=4
autocmd BufLeave *.rb set softtabstop=4

"Setting file type to eruby and html (snippets)
autocmd FileType eruby set ft=eruby.eruby-rails.html
