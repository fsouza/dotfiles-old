autocmd FileType rust setlocal expandtab shiftwidth=4

let g:racer_cmd = $HOME.'/.cargo/bin/racer'
let $RUST_SRC_PATH = $HOME.'/opt/src/rustc/src'
let g:racer_experimental_completer = 1
