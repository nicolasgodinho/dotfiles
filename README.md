Nicolas' dotfiles
=================


Installation
------------

```bash
# Let's be safe and clone the repository inside a dedicated directory
git clone --recursive https://github.com/nicolasgodinho/dotfiles.git ~/DOTFILES

# Symlinks from the repository files to the home directory
ln -s ~/DOTFILES/{.bashrc,.Xdefaults,.vimrc,.vim} ~
```

Bash configuration contents
---------------------------

- Custom `PS1` Bash prompt with current git branch indicator


Vim configuration contents
--------------------------

- Custom Vim configuration
- Pathogen 2.3 for managing Vim plugins (https://github.com/tpope/vim-pathogen)
- Molokai colorscheme (https://github.com/tomasr/molokai)

The following plugins are added as git submodules:

- `ctrlp` for searching files in project easily (https://github.com/kien/ctrlp.vim)
- `lightline` for having a nice (and lightweight!) status line in Vim (https://github.com/itchyny/lightline.vim)
- `nerdtree` for having a side project tree (https://github.com/scrooloose/nerdtree)
- `rainbow_parentheses` to help identify closing brackets (https://github.com/kien/rainbow_parentheses.vim)
- `indent-guides` to help during re-identation of Python code (https://github.com/nathanaelkane/vim-indent-guides)


tmux configuration contents
---------------------------

- Custom status line and keybindings

