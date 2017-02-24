Nicolas' dotfiles
=================


Installation
------------

    # Clone the repository in a dedicated directory
    git clone <DOTFILES_GIT_CLONE_URL> ~/DOTFILES

    # Fetch the last version of all the Git submodules
    cd ~/DOTFILES
    git submodule init .
    git submodule update

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
    mkdir ~/.gnupg
    ln -s ~/DOTFILES/gnupg ~/.gnupg
    # etc...


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

