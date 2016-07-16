#vimfiles

##Getting started

If you want to use this repository, you'll need to download and install it, and
also install all its dependencies.

###Downloading

All you need to do is clone the repository in your $VIMHOME, source the
configuration and install plugins:

	% git clone https://github.com/fsouza/vimfiles.git ${HOME}/.vim
	% echo "source ${HOME}/.vim/init.vim" > ${HOME}/.vimrc
	% vim +PlugInstall
