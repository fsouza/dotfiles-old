"Increase HTML indent
let g:html_indent_inctags="html,head,body,tbody"

"Setting file type to htmldjango and html
autocmd FileType htmldjango set ft=htmljinja.htmldjango.html
autocmd FileType html set ft=htmljinja.htmldjango.html
autocmd FileType xhtml set ft=htmljinja.htmldjango.html

"Setting syntax to htmldjango and html
autocmd FileType htmldjango set syntax=htmljinja
autocmd FileType html set syntax=htmljinja
autocmd FileType xhtml set syntax=htmljinja

"Surrounds for Django templates
autocmd FileType htmldjango let g:surround_{char2nr("b")} = "{% block\1 \r..*\r &\1%}\r{% endblock %}"
autocmd FileType htmldjango let g:surround_{char2nr("i")} = "{% if\1 \r..*\r &\1%}\r{% endif %}"
autocmd FileType htmldjango let g:surround_{char2nr("w")} = "{% with\1 \r..*\r &\1%}\r{% endwith %}"
autocmd FileType htmldjango let g:surround_{char2nr("c")} = "{% comment\1 \r..*\r &\1%}\r{% endcomment %}"
autocmd FileType htmldjango let g:surround_{char2nr("f")} = "{% for\1 \r..*\r &\1%}\r{% endfor %}"
