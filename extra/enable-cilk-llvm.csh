set cilk_path=/opt/llvm-cilk
set path=(/opt/llvm-cilk/bin $path)
setenv C_INCLUDE_PATH ${C_INCLUDE_PATH}:${cilk_path}/include
setenv CPLUS_INCLUDEPATH ${CPLUS_INCLUDE_PATH}:${cilk_path}/include
setenv LIBRARY_PATH ${LIBRARY_PATH}:${cilk_path}/lib
setenv DYLD_LIBRARY_PATH ${DYLD_LIBRARY_PATH}:${cilk_path}/lib
rehash
