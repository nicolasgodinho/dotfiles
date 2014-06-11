" Magic trick: automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


""""""""""""""""""
" VIM APPEARANCE "
""""""""""""""""""

" Syntax coloring
filetype off
filetype plugin indent on
syntax on
set syntax=on

" Colorscheme
if &term =~ "256color" || &term == "builtin_gui" || &term == "rxvt-256color"
    set t_Co=256
    " Molokai <https://github.com/tomasr/molokai>
    colorscheme molokai
else
    colorscheme torte
endif
" No color for the background, I like my terminal transparency.
hi Normal ctermbg=None
set background=dark

" Line numbers
set number

" Cursor line
set cursorline

" Show shady characters : spaces, tabs
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Colorize the 80th column
set colorcolumn=80
hi ColorColumn ctermbg=8

" A ruler in the bottom-right corner to localize myself in the file
set ruler
set laststatus=2


"""""""""""""""""
" VIM USABILITY "
"""""""""""""""""

" Consider the keys : and ; as the same in normal mode.
nnoremap ; :

" Automatic indentation and copy the preivous identation on autoindenting
set autoindent
set copyindent

" Press <F2> to prevent the identation mess issue when pasting code
set pastetoggle=<F2>

" Get rid from the archaic Vi compatibility
set nocompatible

" Allows the use of backspace character (CTRL-H)
set backspace=2

" Tabulation behavior: 4 spaces and never a tab character
set expandtab
set shiftround
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Text width set to 79 chars but without forcing the text wrapping
set textwidth=79
set formatoptions-=t

" Easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Easier re-indenting paragraph in visual mode
vnoremap < <gv
vnoremap > >gv

" I still like to use my mouse sometimes.
set mouse=a

" A better menu
set wildmenu

" Longer history
set history=500
set undolevels=500

" Watch for file modifications
set autoread

" UTF-8 is my default encoding
set encoding=utf8

" Preferred file formats/line terminators (LF > CRLF > CR)
set ffs=unix,dos,mac

" Highlight search
set hlsearch

" Press F3 to toggle highlighting on/off, and show current value.
noremap <F3> :set hlsearch! hlsearch?<CR>

" Incremental Search
set is

" Ignore case by default for searches with smart case searching
set ignorecase
set smartcase

" Show matching braces
set showmatch

" Awesome select-search-and-replace trick in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" More intuitive new split placing
set splitbelow
set splitright

" Move around windows easily
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Move around tabs easily
map <C-n> <ESC>:tabprevious<CR>
map <C-m> <ESC>:tabnext<CR>

" I prefer to navigate through 'visual' lines than hard lines
map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>


""""""""""""""
" GVIM STUFF "
""""""""""""""

" Font for GVim
set guifont=Inconsolata\ 12

" Use CTRL-S for saving, also in Insert mode (GVim)
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" GVim GUI customization
set guioptions-=m  " Menu bar
set guioptions-=T  " Toolbar
set guioptions-=r  " Right-hand scroll bar
set guioptions-=L  " Left-hand scroll bar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

" Alt+Arrows for moving between windows/splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" Alt+Number to move between tabs
nmap <A-1> :tabnext 1<CR>
nmap <A-2> :tabnext 2<CR>
nmap <A-3> :tabnext 3<CR>
nmap <A-4> :tabnext 4<CR>
nmap <A-5> :tabnext 5<CR>
nmap <A-6> :tabnext 6<CR>
nmap <A-7> :tabnext 7<CR>
nmap <A-8> :tabnext 8<CR>
nmap <A-9> :tabnext 9<CR>

" Shift+Alt+Arrows to move between tabs
nmap <S-A-Right> :tabnext<CR>
nmap <S-A-Left> :tabprevious<CR>

" Activate visual mode in normal mode
nmap <S-Up> V
nmap <S-Down> V
nmap <S-Left> v
nmap <S-Right> v


"""""""""""""
" TMUX HACK "
"""""""""""""

" Little hack for tmux
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif


"""""""""""""""
" VIM PLUGINS "
"""""""""""""""

" Pathogen <https://github.com/tpope/vim-pathogen>
execute pathogen#infect()

" NERDTree <https://github.com/scrooloose/nerdtree>

" VIM Lightline <https://github.com/itchyny/lightline.vim>
let g:lightline = {
    \ 'colorscheme': 'powerline',
\ }

" ctrlp.vim <https://github.com/kien/ctrlp.vim>

" Vim Indent Guides <https://github.com/nathanaelkane/vim-indent-guides>

" Rainbow Parentheses <https://github.com/kien/rainbow_parentheses.vim>

" Vim-GitGutter <https://github.com/airblade/vim-gitgutter>

