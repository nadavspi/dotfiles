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
Plugin 'itchyny/lightline.vim'
Plugin 'chriskempson/vim-tomorrow-theme'

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

" utils
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'wellle/targets.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'justinmk/vim-sneak'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'godlygeek/tabular'

" code
Plugin 'scrooloose/syntastic'

" html/css
Plugin 'mattn/emmet-vim'
Plugin 'JulesWang/css.vim'
Plugin 'ap/vim-css-color'
Plugin 'othree/html5.vim'
Plugin 'csscomb/vim-csscomb'
Plugin 'jiangmiao/auto-pairs'

call vundle#end()
filetype plugin indent on

" General
""""""""""
colorscheme Tomorrow-Night-Eighties
syntax on
set number
set ruler
set backspace=indent,eol,start
let mapleader = ","
set visualbell

" cursorline on current window only
:au WinEnter * :setlocal cursorline
:au WinLeave * :setlocal nocursorline

" Filetypes
""""""""""
autocmd BufNewFile,BufRead *.phtml set filetype=php

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

" Unset the 'last search pattern' highlight 
nnoremap <leader><space> :noh<CR>

" Abbreviations
""""""""""
abbreviate lenght length 


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

" Lightline (statusline)
""""""""""
let g:lightline = {
      \ 'active': {
      \    'right': [ [ 'fugitive' ] ]
      \  },
      \  'component': {
      \    'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \   },
      \  'component_visible_condition': {
      \    'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \  }
      \ }

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
