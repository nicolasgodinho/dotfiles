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
    ln -s ~/DOTFILES/xsession ~/.xsession
    ln -s ~/DOTFILES/xinitrc ~/.xinitrc
    ln -s ~/DOTFILES/Xdefaults ~/.Xdefaults
    ln -s ~/DOTFILES/i3 ~/.i3
    ln -s ~/DOTFILES/tmux.conf ~/.tmux.conf
    ln -s ~/DOTFILES/vim ~/.vim
    ln -s ~/DOTFILES/vimrc ~/.vimrc
    mkdir ~/.config
    ln -s ~/DOTFILES/config/dunst ~/.config
    ln -s ~/DOTFILES/config/fontconfig ~/.config
    ln -s ~/DOTFILES/config/awesome ~/.config


Requirements
------------

- Fonts (mainly for i3wm, graphical terminals):
    - [Dina](https://www.donationcoder.com/Software/Jibz/Dina/)
    - [Artwiz fonts](http://artwizaleczapka.sourceforge.net/)
    - [GNU FreeFont](https://www.gnu.org/software/freefont/): containing
      FreeSans, FreeSerif and FreeMono which are free (as in speech and beer)
      replacement fonts for (respectively) **Helvetica**, **Times** and
      **Courier**.

- Programs (for i3wm integration):
    - [Dunst](http://knopwob.org/dunst/index.html): a lightweight
      notification-daemon
    - [Volume Icon](http://softwarebakery.com/maato/volumeicon.html): a
      lightweight volume control in the traybar
    - [i3lock](http://i3wm.org/i3lock/): an ultra-simple screen locker
    - [nitrogen](http://projects.l3ib.org/nitrogen/): a wallpaper manager for X
      window systems

- Small tweaks not versioned in this Git repository:
    - Authorize the execution of `zzz` or `pm-suspend` in the `sudoers` file
      for the current user to be able to put the computer in suspended mode
      without having to type a sudoer password.


Bash configuration contents
---------------------------

- Custom colored Bash prompt with indicator of the current Git branch
- Personal (but still quite standard) Bash aliases compatible with Linux (Void,
  Arch, Debian, Ubuntu), FreeBSD, OpenBSD and Mac OS X
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

