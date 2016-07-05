if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

set nocompatible

call plug#begin('~/.vim/plugged')

" Plugins
""""""""""

" aesthetic
Plug 'reedes/vim-thematic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'reedes/vim-colors-pencil'

" tpope
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'

" utils
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'wellle/targets.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'godlygeek/tabular'
Plug 'nixon/vim-vmath'
Plug 'kana/vim-textobj-user'
Plug 'tyru/open-browser.vim'
Plug 'bronson/vim-trailing-whitespace'

" code
Plug 'scrooloose/syntastic'
" Plug 'StanAngeloff/php.vim'
" Plug 'shawncplus/phpcomplete.vim'
Plug 'dsawardekar/wordpress.vim'

" frontend
Plug 'mattn/emmet-vim'
Plug 'Raimondi/delimitMate'
Plug 'JulesWang/css.vim'
Plug 'othree/html5.vim'
Plug 'csscomb/vim-csscomb'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" writing
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()


" General
""""""""""
set number
set ruler
set backspace=indent,eol,start
let mapleader = "\<Space>"
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

" go source vimrc
nnoremap gsv :source $MYVIMRC<cr>

" go install plugins
nnoremap gip :PluginInstall<cr>

" go edit hosts file
nnoremap geh :e /etc/hosts<cr>

map ; :
noremap ;; ;

inoremap jk <Esc>:w<cr>
inoremap kk <Esc>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap <leader>s :w<cr>

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

nnoremap <C-p> :GFiles<cr>

" Emmet
let g:user_emmet_leader_key = '<c-e>'

" Buffers
nnoremap <leader>1 :buffer 1<cr>
nnoremap <leader>2 :buffer 2<cr>
nnoremap <leader>3 :buffer 3<cr>
nnoremap <leader>4 :buffer 4<cr>
nnoremap <leader>5 :buffer 5<cr>
nnoremap <leader>6 :buffer 6<cr>
nnoremap <leader>7 :buffer 7<cr>
nnoremap <leader>8 :buffer 8<cr>

" duplicate and comma-ize CSS
nnoremap gy :norm yypk$hC,<cr>:norm j0<cr>

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
let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0

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
let delimitMate_expand_space = 1

" vim-textobj-user (custom text objects)
""""""""""""""""""""""""""""""""""""""""

call textobj#user#plugin('php', {
\   'code': {
\     'pattern': ['<?php\>', '?>'],
\     'select-a': 'aP',
\     'select-i': 'iP',
\   },
\ })

" open-browser
""""""""""""""

" If URI, open. Othwrwise, search.
nnoremap gb <Plug>(openbrowser-smart-search)
vnoremap gb <Plug>(openbrowser-smart-search)

" Colemak stuff
nnoremap n j
nnoremap e k
nnoremap i l
nnoremap u i
nnoremap l u
nnoremap k n
nnoremap K N
