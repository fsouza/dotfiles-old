#Francisco Souza's vim files.

##Getting started

If you want to use my vimfiles, you'll need to download and install it. Here are these two steps described:

###Downloading

####With git...

If you have git installed on your computer, all you need to do is to clone the repository on your ``$VIMHOME``:

    $ cd $HOME
    $ git clone git://github.com/franciscosouza/vimfiles.git .vim

Then enter in the ``.vim`` directory and update the submodules:

    $ cd $HOME/.vim
    $ git submodule init
    $ git submodule update

####Without git...

So, you don't have git on your computer? Install it :P

###Installing

After download the packages with or without git, 
all you need to do is create a ``.vimrc`` on your ``$HOME``:

    $ echo "source $HOME/.vim/.vimrc" > $HOME/.vimrc

###JavaScript lint

In order to use JavaScript lint, you need to add the ``jsl`` executable to your ``PATH``. [Download it](http://javascriptlint.com/download.htm) and add to a directory in your ``PATH``.
