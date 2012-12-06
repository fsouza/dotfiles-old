#vimfiles

##Getting started

If you want to use my vimfiles, you'll need to download and install it. Here
are these two steps described:

###Downloading

All you need to do is to clone the repository on your ``$VIMHOME``:

    % cd ${HOME}
    % git clone git://github.com/fsouza/vimfiles.git .vim

Then enter in the ``.vim`` directory and update the submodules:

    % cd ${HOME}/.vim
    % git submodule update --init --recursive

It's necessary to make a recursive update, because there is a submodule with
another submodule inside it (pyflakes-vim).

###Installing

After download the project, you need create a ``.vimrc`` file in your ``$HOME``:

    % echo "source ${HOME}/.vim/.vimrc" > ${HOME}/.vimrc

###JavaScript lint

In order to use JavaScript lint, you need to add the ``jsl`` executable to your
``PATH``. [Download it](http://javascriptlint.com/download.htm) and add to a
directory in your ``PATH``.

Alternatively, you can use ``brew`` to install it on Mac OS X:

	% brew install jsl

On FreeBSD you can install it using ports:

    % cd /usr/ports/devel/jsl
    # make install clean

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
