set nocompatible
filetype off

" Vundle 
""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'itchyny/lightline.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-haml'
Plugin 'mattn/emmet-vim'
Plugin 'JulesWang/css.vim'
Plugin 'ap/vim-css-color'
Plugin 'othree/html5.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-commentary'
Plugin 'AndrewRadev/splitjoin.vim'

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
set cursorline

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

" Unset the 'last search pattern' highlight 
nnoremap <leader><space> :noh<CR>

" Key bindings
""""""""""
nnoremap <tab> %
inoremap <tab> <c-x><c-o>

" Vim fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit -m "
nnoremap <leader>gp :Git push<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Line numbers
""""""""""
if exists('+relativenumber')
  set relativenumber

  " Always show line numbers, but only in current window.
  :au WinEnter * :setlocal relativenumber
  :au WinLeave * :setlocal norelativenumber

  " Absolute Line Numbers in Insert Mode
  :au InsertEnter * :set relativenumber!
  :au InsertLeave * :set relativenumber
endif

" Line length and wrapping
""""""""""
set wrap
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
