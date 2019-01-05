# vimfiles

## Getting started

If you want to use this repository, you'll need to download and install it, and
also install all its dependencies.

This repository uses [neovim's](https://github.com/neovim/neovim) nomenclature.

### Using with Neovim

All you need to do is clone the repository in your ``$VIMHOME`` and then
initialize the submodules:

```
% git clone --recurse-submodules https://github.com/fsouza/vimfiles.git ${HOME}/.config/nvim
% make -f ${HOME}/.config/nvim/Makefile bootstrap
% nvim +PlugInstall
```

### Using with Vim

You may optionally use it with Vim instead of NeoVim:

```
% git clone --recurse-submodules https://github.com/fsouza/vimfiles.git ${HOME}/.vim
% make -f ${HOME}/.vim/Makefile bootstrap
% echo "source ${HOME}/.vim/init.vim" > ${HOME}/.vimrc
% vim +PlugInstall
```
