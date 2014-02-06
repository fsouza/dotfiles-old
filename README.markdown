#vimfiles

##Getting started

If you want to use this repository, you'll need to download and install it, and
also install all its dependencies.

###Downloading

All you need to do is to clone the repository on your ``$VIMHOME``:

	% cd ${HOME}
	% git clone git://github.com/fsouza/vimfiles.git .vim

Then enter in the ``.vim`` directory and update the submodules:

	% cd ${HOME}/.vim
	% git submodule update --init --recursive

###Installing

After download the project, you need create a ``.vimrc`` file in your ``$HOME``:

	% echo "source ${HOME}/.vim/.vimrc" > ${HOME}/.vimrc
