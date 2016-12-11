#vimfiles

##Getting started

If you want to use this repository, you'll need to download and install it, and
also install all its dependencies.

This repository uses [neovim's](https://github.com/neovim/neovim) nomenclature.

###Downloading

All you need to do is clone the repository in your ``$NVIMHOME`` and then
initialize the submodules:

```
% mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
% git clone https://github.com/fsouza/vimfiles.git ${XDG_CONFIG_HOME}/nvim
% nvim +PlugInstall
```

###Using with Vim

You may optionally use it with Vim instead of NeoVim:

```
% git clone https://github.com/fsouza/vimfiles.git ${HOME}/.vim
% echo "source ${HOME}/.vim/init.vim" > ${HOME}/.vimrc
% vim +PlugInstall
```
