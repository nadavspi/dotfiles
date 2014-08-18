set nocompatible
filetype off

" Vundle 
""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
""""""""""

" aesthetic
Plugin 'bling/vim-airline'
" Plugin 'itchyny/lightline.vim'
Plugin 'reedes/vim-thematic'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'reedes/vim-colors-pencil'

" tpope
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-rails'

" utils
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'wellle/targets.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'justinmk/vim-sneak'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'godlygeek/tabular'
Plugin 'nixon/vim-vmath'

" code
Plugin 'scrooloose/syntastic'

" frontend
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'JulesWang/css.vim'
Plugin 'ap/vim-css-color'
Plugin 'othree/html5.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'csscomb/vim-csscomb'
Plugin 'pangloss/vim-javascript'
Plugin 'mustache/vim-mustache-handlebars'

" writing
Plugin 'reedes/vim-pencil'
Plugin 'junegunn/goyo.vim'
Plugin 'junegunn/limelight.vim'

if executable('dayone')
  Plugin 'glidenote/newdayone.vim'
endif


call vundle#end()
filetype plugin indent on

" General
""""""""""
syntax on
set number
set ruler
set backspace=indent,eol,start
let mapleader = ","
set visualbell

set nobackup
set noswapfile

" automatically re-read files that have been changed outside of vim 
set autoread

" cursorline on current window only
:au WinEnter * :setlocal cursorline
:au WinLeave * :setlocal nocursorline

" highlight 81st column of wide lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Filetypes
""""""""""
autocmd BufNewFile,BufRead *.phtml set filetype=php
autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

" Tabs
""""""""""
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2

" Search
""""""""""
set ignorecase
set smartcase
set incsearch
set nohlsearch

" Unset the 'last search pattern' highlight 
nnoremap <leader><space> :noh<CR>

" Abbreviations
""""""""""
abbreviate lenght length 
abbreviate dont' don't


" Key bindings
""""""""""

" go edit vimrc 
nnoremap gev :vsplit $MYVIMRC<cr>

" go edit hosts file
nnoremap geh :e /etc/hosts<cr>

map ; :
noremap ;; ;

inoremap jk <Esc>:w<cr>
inoremap kk <Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap <leader>t :tabnew<cr>

nnoremap <tab> %
inoremap <tab> <c-x><c-o>

" toggle folds, because za is awkward 
nnoremap zo za
nnoremap zc za

" Vim fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit -m ""<left>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gm :Git amend<cr>

" edit files relative to current dir
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" CtrlP
nnoremap <leader>r :CtrlPMRU<cr>
" CtrlP shortcuts for Magento
nnoremap gms :CtrlP skin/frontend<cr>
nnoremap gmd :CtrlP app/design/frontend<cr>
" Notes
nnoremap gn :CtrlP ~/Dropbox/Notes<cr>
nnoremap gwn :CtrlP ~/Dropbox/NotesWork<cr>

" Emmet
let g:user_emmet_leader_key = '<c-e>'

" Line numbers
""""""""""
if exists('+relativenumber')
  set relativenumber

  " Always show line numbers, but only in current window.
  :au WinEnter * :setlocal relativenumber
  :au WinLeave * :setlocal norelativenumber
endif

" Line length and wrapping
""""""""""
set wrap
set linebreak
set textwidth=79
set formatoptions=qrn1

" Windows
""""""""""
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>v <C-w>
set splitbelow
set splitright

" Airline
""""""""""
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c'],
    \ [ 'warning' ]
    \ ]
let g:airline#extensions#tabline#enabled = 1

" Tmuxline
""""""""""
" let g:tmuxline_preset = {
"     \ 'a' : '[#S]',
"     \ 'z' : '[#h]',
"     \ 'win': '#I:#W#F',
"     \ 'cwin': '#I:#W#F',
"     \ 'options': {
"         \'status-justify': 'centre'
"         \ }
"     \ }

" Lightline (statusline)
""""""""""
" let g:lightline = {
"       \ 'colorscheme': 'solarized_light',
"       \ 'active': {
"       \    'right': [ [ 'fugitive' ] ]
"       \  },
"       \  'component': {
"       \    'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
"       \   },
"       \  'component_visible_condition': {
"       \    'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"       \  }
"       \ }

" Ag / The Silver Searcher
""""""""
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" tmux
""""""""

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Sneak
""""""""

nmap <enter> <Plug>SneakNext
xmap <enter> <Plug>SneakNext
nmap <bs>    <Plug>SneakPrevious
xmap <bs>    <Plug>SneakPrevious

" Case sensitivity is determined by 'ignorecase' and 'smartcase'.
let g:sneak#use_ic_scs = 1

" Private gists by default
let g:gist_post_private = 1

" Syntastic
""""""""
let g:syntastic_scss_checkers = ['scss_lint']


" Pencil
""""""""
let g:pencil#wrapModeDefault = 'soft'  
" disable switch to next line with h/l
let g:pencil#cursorwrap = 0  

" Thematic
""""""""
let g:thematic#theme_name = 'tomorrow'
let g:thematic#defaults = {
      \ 'background': 'dark',
      \ 'laststatus': 2,
      \ 'ruler': 0,
\ }
let g:thematic#themes = {
      \ 'solarized_light' : {
      \ 'colorscheme': 'solarized',
      \ 'background': 'light',
      \ 'airline-theme': 'solarized',
      \ },
      \ 'solarized_dark' : {
      \ 'colorscheme': 'solarized',
      \ 'airline-theme': 'solarized',
      \ },
      \ 'tomorrow' : {
      \ 'colorscheme': 'Tomorrow-Night-Eighties',
      \ 'background': 'dark',
      \ 'airline-theme': 'tomorrow',
      \ },
      \ 'pencil' :{'colorscheme': 'pencil',
      \                 'background': 'light',
      \                 'laststatus': 0,
      \                },
  \ }

" Goyo
""""""""

function! GoyoBefore()
  if exists('$TMUX')
    silent !tmux set status off
  endif
  set scrolloff=999
  set noshowmode
  set noshowcmd
  set nocursorline
  set norelativenumber
  TogglePencil
endfunction

function! GoyoAfter()
  if exists('$TMUX')
    silent !tmux set status on
  endif
  set scrolloff=5
  set showmode
  set showcmd
  set cursorline
  set relativenumber
  NoPencil
endfunction

let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]

let g:goyo_width = 68

" Vmath
""""""""
vmap <expr>  ++  VMATH_YankAndAnalyse()
nmap         ++  vip++

" delimitMate
"""""""""""""
let delimitMate_expand_cr = 1
