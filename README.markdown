#Francisco Souza's vim files.

##Getting started

If you want to use my vimfiles, you'll need to download and install it. Here are these two steps described:

###Downloading

####With git...

If you have git installed on your computer, all you need to do is to clone the repository on your ``$VIMHOME``:

    $ cd $HOME
    $ git clone git://github.com/fsouza/vimfiles.git .vim

Then enter in the ``.vim`` directory and update the submodules:

    $ cd $HOME/.vim
    $ git submodule init
    $ git submodule update --init --recursive

It's necessary to make a recursive update, because there is a submodule with another submodule inside it (pyflakes-vim).

####Without git...

So, you don't have git on your computer? Install it :P

###Installing

After download the packages with or without git,
all you need to do is create a ``.vimrc`` on your ``$HOME``:

    $ echo "source $HOME/.vim/.vimrc" > $HOME/.vimrc

###JavaScript lint

In order to use JavaScript lint, you need to add the ``jsl`` executable to your ``PATH``. [Download it](http://javascriptlint.com/download.htm) and add to a directory in your ``PATH``.

###csstidy

You will need also to install ``csstidy``. Just download it, extract, compile and add the executable to your path:

    $ curl -O "http://ufpr.dl.sourceforge.net/project/csstidy/CSSTidy%20%28C%2B%2B%2C%20stable%29/1.3/csstidy-source-1.4.zip"
    $ unzip csstidy-source-1.4.zip
    $ cd csstidy
    $ g++ *.cpp -0 csstidy
    $ [sudo] cp csstidy /usr/local/bin

You might use [SCons](http://www.scons.org/) to build csstidy, but it's not really necessary.
