#Francisco Souza's vim files.

##Getting started

If you want to use my vimfiles, clone the repository on your ``$VIMHOME``:

    $ cd $HOME
    $ git clone git://github.com/franciscosouza/vimfiles.git .vim

Then, enter in the ``.vim`` directory and update the submodules:

    $ cd $HOME/.vim
    $ git submodule init
    $ git submodule update

The last step is create a ``.vimrc`` on your ``$HOME``:

    $ echo "source $HOME/.vim/.vimrc" > $HOME/.vimrc

##Command-T

[Command-T](https://github.com/wincent/Command-T) is a plugin written in Ruby for fast opening files. If you want to use it, you'll need to compile it:

    $ cd $HOME/.vim/bundle/Command-T/ruby/command-t
    $ ruby extconf.rb
    $ make

Make sure you have Ruby headers files (on Ubuntu, you need to install the ``ruby-dev`` package).
