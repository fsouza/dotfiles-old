
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')

let g:merlin = {'merlin_home': g:opamshare . "/merlin"}
execute "set rtp+=" . g:opamshare . "/merlin/vim"
