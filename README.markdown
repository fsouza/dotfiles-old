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

###lint

I use [lint.vim](https://github.com/joestelmach/lint.vim) for JavaScript and
CSS linting. They depend on v8 being installed (without shared libraries).

You can use ``brew`` to install V8 on Mac OS X:

	% brew install v8

Or install it from ports on FreeBSD:

	% cd /usr/ports/lang/v8
	$ make install clean

For installation from source, please check [lint.vim
readme](https://github.com/joestelmach/lint.vim#installation).

###csstidy

You will need also to install ``csstidy``.

You can use ``brew`` to install it on Mac OS X:

	% brew install csstidy

Or install it from ports on FreeBSD:

	% cd /usr/ports/www/csstidy
	# make install clean

You can also download it and build from source using your preferred c++
compiler:

	% curl -L http://sourceforge.net/projects/csstidy/files/CSSTidy%20%28C%2B%2B%2C%20stable%29/1.3/csstidy-source-1.4.zip/download -o csstidy.zip
	% unzip csstidy.zip
	% cd csstidy
	% clang++ *.cpp -o csstidy

After building, put it somewhere in your shell path.
