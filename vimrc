set term=builtin_ansi
syntax on
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py inoremap # X^H#
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
autocmd BufRead * set softtabstop=4
autocmd BufRead *.py set autoindent
autocmd BufRead *.py highlight BadWhitespace ctermbg=red guibg=red
autocmd BufRead *.py match BadWhitespace /^\t\+/
autocmd BufRead *.py match BadWhitespace /\s\+$/
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=html.django_template " For SnipMate"
autocmd BufRead * python setIndentation()

python << EOF
def setIndentation():
   import vim
   maxSearch = 1000     #  max number of lines to search through

   indentSpaces = None
   cb = vim.current.buffer
   indentCount = { ' ' : 0, '	' : 0 }
   justSawDefOrClassLine = 0
   for i in xrange(0, min(maxSearch, len(cb))):
      line = cb[i]
      if not line: continue

      #  count spaces after a class or def line
      if justSawDefOrClassLine:
         justSawDefOrClassLine = 0
         if line[0] == ' ':
            indentSpaces = 0
            for c in line:
               if c != ' ': break
               indentSpaces = indentSpaces + 1
      if line[:4] == 'def ' or line[:6] == 'class ':
         justSawDefOrClassLine = 1

      #  add to tab versus space count
      if line[0] in ' 	':
         indentCount[line[0]] = indentCount.get(line[0], 0) + 1

   #  more lines started with space
   if indentCount[' '] > indentCount['	']:
      vim.command('set smarttab tabstop=4 expandtab')
      if indentSpaces:
         vim.command('set ts=%d sw=%d' % ( indentSpaces, indentSpaces ))

   #  more lines started with tab
   else:
      vim.command('set softtabstop=3 ts=3 sw=3')
EOF

colorscheme Dark
nmap <silent> <c-p> :NERDTreeToggle<CR>
nnoremap <c-o> :FufFile<CR>
nnoremap <c-l> :FufDir<CR>
