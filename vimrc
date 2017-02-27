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
set background=dark
if &t_Co == 256
    " Molokai <https://github.com/tomasr/molokai>
    colorscheme molokai
else
    colorscheme elflord
endif

" Line numbers
set number

" Cursor line
set cursorline

" Show shady characters : spaces, tabs
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:\u2022,extends:\uBB,precedes:\uAB"
set list

" Colorize the 80th column
set colorcolumn=80

" A ruler in the bottom-right corner to localize myself in the file
set ruler
set laststatus=2

" Always show the tabline (which is heavily modified by lightline-bufferline)
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

" Allow saving of files as sudo when I forgot to start vim using sudo.
" Source: http://stackoverflow.com/questions/2600783
cmap w!! w !sudo tee > /dev/null %

" Awesome select-search-and-replace trick in visual mode:
" Replace on demand (`c') in the current buffer:
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
" Replace in all opened buffers (neither asking for replace nor saving buffers)
vnoremap <C-A-r> "hy:bufdo! %s/<C-r>h//ge<left><left><left>

" Cycle around buffers easily with Tab in normal mode
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" More intuitive new split placing
set splitbelow
set splitright

" Move around splits easily
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" I prefer to navigate through 'visual' lines than hard lines
map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>

" Useful keybindings to create splits where I want. Shamelessly grabbed from:
" https://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/
" window
nmap <leader>sw<left>  :topleft  vnew<CR>
nmap <leader>sw<right> :botright vnew<CR>
nmap <leader>sw<up>    :topleft  new<CR>
nmap <leader>sw<down>  :botright new<CR>
" buffer
nmap <leader>s<left>   :leftabove  vnew<CR>
nmap <leader>s<right>  :rightbelow vnew<CR>
nmap <leader>s<up>     :leftabove  new<CR>
nmap <leader>s<down>   :rightbelow new<CR>


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
set guioptions-=e  " Tabs bar
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

" Alt+Arrows for moving between windows/splits
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" To move between tabs
nmap <Leader>t :tabs<CR>
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

"
" Pathogen <https://github.com/tpope/vim-pathogen>
"
execute pathogen#infect()

"
" Vim-Abolish <https://github.com/tpope/vim-abolish>
"
"nothing


"
" NERDTree <https://github.com/scrooloose/nerdtree>
"
nmap <F1> :NERDTreeFocus<CR>
nmap <Leader>nt :NERDTreeToggle<CR>


"
" Lightline <https://github.com/itchyny/lightline.vim>
"
let g:lightline = {
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'spell', 'syntastic' ],
    \             [ 'fugitive' ] ],
    \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'colorscheme': 'powerline',
    \ 'component_function': {
        \ 'mode': 'LightlineMode',
        \ 'readonly': 'LightlineReadonly',
        \ 'fugitive': 'LightlineFugitive',
        \ 'filename': 'LightlineFilename',
        \ 'fileformat': 'LightlineFileformat',
        \ 'fileencoding': 'LightlineFileencoding',
        \ 'filetype': 'LightlineFiletype',
        \ },
    \ }

function! LightlineModified()
    return &ft =~ 'help\|vimfiler\|nerdtree' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|nerdtree' && &readonly ? 'RO' : ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 60 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 60 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 60 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:~:.')
    return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
                \ fname == '__Tagbar__' ? g:lightline.fname :
                \ fname =~ '__Gundo\|NERD_tree' ? '' :
                \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
                \ &ft == 'unite' ? unite#get_status_string() :
                \ &ft == 'vimshell' ? vimshell#get_status_string() :
                \ ('' != fname ? fname : '[No Name]')
endfunction

function! LightlineFugitive()
    " display Git branch only when window is wide
    if (winwidth(0) < 100)
        return ''
    endif
    if &ft !~? 'vimfiler' && exists('*fugitive#head')
        let branch = fugitive#head()
        return ('' != l:branch ? '┢ ' . branch : '')
    endif
    return ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
            \ fname == 'ControlP' ? 'CtrlP' :
            \ fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ fname =~ 'NERD_tree' ? 'NERDTree' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ &ft == 'vimshell' ? 'VimShell' :
            \ winwidth(0) > 50 ? lightline#mode() : ''
endfunction

"
" Lightline-bufferline <https://github.com/mgee/lightline-bufferline>
"
let g:lightline.tabline = {
    \ 'left': [['buffers']],
    \ 'right': [[]],
    \ }
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}
let g:lightline#bufferline#filename_modifier = ':~:.'
let g:lightline#bufferline#modified = ' +'
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unnamed = '[No Name]'


"
" Vim Indent Guides <https://github.com/nathanaelkane/vim-indent-guides>
"
nmap <Leader>ig :IndentGuidesToggle<CR>


"
" Vim-GitGutter <https://github.com/airblade/vim-gitgutter>
"
nmap <Leader>gg :GitGutterToggle<CR>
nmap <Leader>GG :GitGutterLineHighlightsToggle<CR>


"
" Syntastic <https://github.com/vim-syntastic/syntastic>
"
nmap <Leader>cs :SyntasticCheck<CR>:let b:syntastic_mode="active"<CR>
nmap <Leader>ccs :SyntasticReset<CR>:let b:syntastic_mode="passive"<CR>
let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


"
" Fugitive <https://github.com/tpope/vim-fugitive>
"
"nothing


"
" WindowSwap.vim <https://github.com/wesQ3/vim-windowswap>
"
"nothing


"
" Tagbar <https://github.com/majutsushi/tagbar>
"
nmap <F8> :TagbarToggle<CR>
" o is for "objects"
nmap <Leader>o :TagbarToggle<CR>
let g:tagbar_autofocus = 1
" never sort symbols because the declaration order in the file is way often
" more important than the alphabetical order
let g:tagbar_sort = 0


"
" CtrlP.vim <https://github.com/ctrlpvim/ctrlp.vim>
"
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


"
" BufExplorer <https://github.com/jlanzarotta/bufexplorer>
"
nmap <Leader>b :BufExplorer<CR>

"
" VimCompletesMe <https://github.com/ajh17/VimCompletesMe>
"
"nothing

"
" Gutentags <https://github.com/ludovicchabant/vim-gutentags>
"
"nothing


"
" Neosnippet <https://github.com/Shougo/neosnippet.vim>
" and its snippets <https://github.com/Shougo/neosnippet-snippets>
"
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
"let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
