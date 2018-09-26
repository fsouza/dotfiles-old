let g:rustfmt_autosave = 1
let g:racer_experimental_completer = 1
let g:racer_insert_paren = 0

let sroot = system('rustc --print sysroot')
let $RUST_SRC_PATH = substitute(sroot, '\n', '', 'g') . '/lib/rustlib/src/rust/src/'
