""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" VIM-PLUG
" use :PlugInstall to install plugins
" c.f. https://github.com/junegunn/vim-plug for how to install, update, etc.
call plug#begin('~/.vim/plugged')

Plug 'rking/ag.vim'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'sjl/gundo.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'mxw/vim-jsx'
Plug 'StanAngeloff/php.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'pangloss/vim-javascript'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" LEADER
let mapleader=","     " leader is comma

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" ESC
imap jj <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" COLORS
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256

try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme peachpuff
endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" GUI
set guifont=Monospace\ 11

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SWAP
set swapfile                     " swap file on
set directory^=$HOME/.tmp/vim//  " store swap files here. you need the ending // to indicate that the directory information will be saved in the filename.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TABS
set tabstop=4         " number of visual spaces per TAB
set shiftwidth=4      " same as tabstop?
set softtabstop=4     " number of spaces in tab when editing
set expandtab         " tabs are spaces
" move tab right
nmap tm :tabm +1<CR>
" move tab left
nmap tn :tabm -1<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" UI
set showcmd           " show command in bottom bar
filetype indent on    " load filetype-specific indent files
"set lazyredraw        " redraw only when we need to.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" SEARCH
set noincsearch       " search as characters are entered
set hlsearch          " highlight matches
" turn off highlight using ,space
nnoremap <leader><space> :nohlsearch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" MOVEMENT
" move vertically by visual line
nnoremap j gj
nnoremap k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" WINDOWS
" navigate windows using ctrl+jklh
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>
set splitbelow      " split horizontally below
set splitright      " split vertically right
nnoremap <leader>= :wincmd =<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" EXPLORER
" nerdtree style
let g:netrw_liststyle=3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
" open explore with ,k
map <leader>k :Texplore<cr>
" open sidebar with ,x
map <leader>x :Vexplore<cr>

" do some mapping only the netrw window (netrw changes some mappings in its buffer)
augroup netrw_map_fixes
    autocmd!
    autocmd filetype netrw call FixNetrwMaps()
augroup END
function! FixNetrwMaps()
    unmap <buffer> t
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" TABS
nmap th :tabprevious<CR>
nmap tl :tabnext<CR>
nmap tt :tabnew<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" CTRL-P
"let g:ctrlp_match_window = 'bottom,order:ttb'  " change results order
let g:ctrlp_switch_buffer = 0       " always open in new buffer
let g:ctrlp_working_path_mode = 0   " make ctrlp respect path change
" use ag
if executable('ag')
  let g:ctrlp_user_command = 'ag %s --nocolor --nogroup --hidden
              \ --ignore vendor
              \ --ignore .git
              \ --ignore .DS_Store
              \ --ignore .idea
              \ -g ""'
  let g:ctrlp_use_caching = 0 " ag is fast enough, don't cache
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" MISC
" highlight last inserted text
nnoremap gV `[v`]
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" save session
nnoremap <leader>s :mksession<CR>
" open Silver Searcher (ag.vim)
nnoremap <leader>a :Ag
" status line
set laststatus=2
set ruler
" using semicolon instead of colon to enter command mode
nmap ; :
" toogle paste
set pastetoggle=<leader>p
" repeat last find (f, F, t, T). need to remap since using ; for :
nnoremap <c-k> ;

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" DIFF
" get the REMOTE diff
nnoremap <leader>R :diffget RE<CR>
" enable text wrapping on diff buffers
autocmd FilterWritePre * if &diff | setlocal wrap< | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" EMMET
let g:user_emmet_leader_key='<C-Z>'     " trigger with C-Z instead of C-Y

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" NUMBERING
" line numbers are relative to current line
set relativenumber
" current line number is absolute
set number

" toggle numbering
nnoremap <leader>n :setlocal number! <bar> :setlocal relativenumber!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" COMMANDS
" find weird characters. useful for finding non-standard whitespace
command Weird /[^\x00-\x7F]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RESOURCES:
"
" http://dougblack.io/words/a-good-vimrc.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
