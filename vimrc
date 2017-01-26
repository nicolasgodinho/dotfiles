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

" Colorize the 81st column
set colorcolumn=81
hi ColorColumn ctermbg=8

" A ruler in the bottom-right corner to localize myself in the file
set ruler
set laststatus=2

" Always show the tabline
set showtabline=2


"""""""""""""""""
" VIM USABILITY "
"""""""""""""""""

" Consider the keys : and ; as the same in normal mode.
nnoremap ; :

" Automatic indentation and copy the previous identation on autoindenting
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
set shiftwidth=4
set softtabstop=4
" But displays tabulation as 8 spaces long
set tabstop=8

" Text width set to 80 chars but without forcing the text wrapping
set textwidth=80
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

" Allow saving of files as sudo when I forgot to start vim using sudo.
" Source: http://stackoverflow.com/questions/2600783
cmap w!! w !sudo tee > /dev/null %

" Awesome select-search-and-replace trick in visual mode:
" Replace on demand (`c') in the current buffer:
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Replace in all opened buffers (neither asking for replace nor saving buffers)
vnoremap <C-A-r> "hy:bufdo! %s/<C-r>h//ge<left><left><left>

" More intuitive new split placing
set splitbelow
set splitright

" Move around windows easily
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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
set guifont=Dina\ 8

" Bind Shift+Insert to paste command when in GVim
" Source: http://superuser.com/questions/322947/
if has("gui_running")
    map <silent> <S-Insert> "+p
    imap <silent> <S-Insert> <Esc>"+pa
endif

" Use CTRL-S for saving, also in Insert mode (GVim)
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" GVim GUI customization
set guioptions+=c  " Dialogs
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
nmap <Leader>1 :tabnext 1<CR>
nmap <Leader>2 :tabnext 2<CR>
nmap <Leader>3 :tabnext 3<CR>
nmap <Leader>4 :tabnext 4<CR>
nmap <Leader>5 :tabnext 5<CR>
nmap <Leader>6 :tabnext 6<CR>
nmap <Leader>7 :tabnext 7<CR>
nmap <Leader>8 :tabnext 8<CR>
nmap <Leader>9 :tabnext 9<CR>
nmap <Leader>0 :tabnext 10<CR>

" Shift+Alt+Arrows to move between tabs
nmap <S-A-Right> :tabnext<CR>
nmap <S-A-Left> :tabprevious<CR>

" Activate visual mode in normal mode
nmap <S-Up> V
nmap <S-Down> V
nmap <S-Left> v
nmap <S-Right> v

" Change GVim appearance easily to adapt screen or context
nmap <F11> :set guifont=Dina\ 6<CR>:colorscheme molokai<CR>
nmap <S-F11> :set guifont=Dina\ 8<CR>:colorscheme molokai<CR>
nmap <F12> :set guifont=Dina\ 10<CR>:colorscheme molokai<CR>
nmap <S-F12> :set guifont=Inconsolata\ 14<CR>:colorscheme molokai<CR>


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
" Toggle NERDTree with F1
nmap <F1> :NERDTreeFocus<CR>
nmap <Leader>nt :NERDTreeToggle<CR>

" VIM Lightline <https://github.com/itchyny/lightline.vim>
let g:lightline = {
    \ 'colorscheme': 'powerline' }
let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }

" Vim Indent Guides <https://github.com/nathanaelkane/vim-indent-guides>
nmap <Leader>ig :IndentGuidesToggle<CR>

" Vim-GitGutter <https://github.com/airblade/vim-gitgutter>
nmap <Leader>gg :GitGutterToggle<CR>
nmap <Leader>GG :GitGutterLineHighlightsToggle<CR>

" Vim-Go <https://github.com/fatih/vim-go>
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>e <Plug>(go-rename)

" Tagbar <https://github.com/majutsushi/tagbar>
nmap <F8> :TagbarToggle<CR>
nmap <Leader>tb :TagbarToggle<CR>

" CtrlP.vim <https://github.com/ctrlpvim/ctrlp.vim>
let g:ctrlp_working_path_mode = 'ra'
"" ctrlp_working_path_mode codes reminder:
""
"" 'c' - the directory of the current file.
"" 'a' - the directory of the current file, unless it is a subdirectory of the
""       cwd
"" 'r' - the nearest ancestor of the current file that contains one of these
""       directories or files: .git .hg .svn .bzr _darcs
"" 'w' - modifier to "r": start search from the cwd instead of the current
""       file's directory
"" 0 or '' (empty string) - disable this feature.

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

"let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

" BufExplorer <https://github.com/jlanzarotta/bufexplorer>
nmap <Leader>be :BufExplorer<CR>
