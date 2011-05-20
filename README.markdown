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

So, you don't have git on your computer? I recommend you start to use, but don't worry, you can still get my vimfiles working by download a tar.gz package:

    $ cd $HOME
    $ wget https://github.com/downloads/franciscosouza/vimfiles/0.2.tar.gz
    $ tar -xvzf 0.2.tar.gz

###Installing

After download the packages with or without git, 
all you need to do is create a ``.vimrc`` on your ``$HOME``:

    $ echo "source $HOME/.vim/.vimrc" > $HOME/.vimrc

###Gist

You need to copy the github.vim.example to github.vim in order to use [Gist.vim](http://www.vim.org/scripts/script.php?script_id=2423).
