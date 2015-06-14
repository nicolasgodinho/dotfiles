Nicolas' dotfiles
=================


Installation
------------

    # Clone the repository in a dedicated directory
    git clone <DOTFILES_GIT_CLONE_URL> ~/DOTFILES

    # Fetch the last version of all the Git submodules
    cd ~/DOTFILES
    git submodule update --init

    # Eventually upgrade all the Git submodules to their latest version
    #git submodule foreach git pull origin master

    # Symlinks from the repository files to the home directory
    ln -s ~/DOTFILES/bashrc ~/.bashrc
    ln -s ~/DOTFILES/Xdefaults ~/.Xdefaults
    ln -s ~/DOTFILES/tmux.conf ~/.tmux.conf
    ln -s ~/DOTFILES/vim ~/.vim
    ln -s ~/DOTFILES/vimrc ~/.vimrc
    mkdir ~/.config
    ln -s ~/DOTFILES/.config/dunst ~/.config


Requirements
------------

- Fonts:
    - [Dina](https://www.donationcoder.com/Software/Jibz/Dina/)
    - [Artwiz fonts](http://artwizaleczapka.sourceforge.net/)


Bash configuration contents
---------------------------

- Custom colored Bash prompt with indicator of the current Git branch
- Personal (but still quite standard) Bash aliases compatible with Linux (Void,
  Aruch, Debian, Ubuntu), FreeBSD, OpenBSD and Mac OS X
- Exported variables for Golang development


Vim configuration contents
--------------------------

- My custom Vim configuration
- [Pathogen 2.3](https://github.com/tpope/vim-pathogen) for managing all Vim
  plugins
- [Molokai](https://github.com/tomasr/molokai) coloscheme for Vim

The following plugins are added as git submodules:

- [`lightline.vim`](https://github.com/itchyny/lightline.vim) for having a nice
  (and lightweight!) status line in Vim
- [NERDTree](https://github.com/scrooloose/nerdtree) for having a side
  project tree
- [Vim indent guides](https://github.com/nathanaelkane/vim-indent-guides) to
  help during re-identation of Python code
- [Vim GitGutter](https://github.com/airblade/vim-gitgutter) to indicate the
  current changes when I'm editing inside a Git repository
- [Vim-Go](https://github.com/fatih/vim-go) for Golang development with Vim


tmux configuration contents
---------------------------

- Custom status line and keybindings


To do list
----------

- A `cshrc` dotfile
- Git useful aliases and local configuration

