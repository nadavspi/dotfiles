set nocompatible
filetype off

" Vundle 
""""""""""
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'mattn/emmet-vim'

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

" Tabs
""""""""""
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Search
""""""""""
set ignorecase
set smartcase

" Unset the 'last search pattern' highlight by hitting enter
nnoremap <CR> :noh<CR><CR>

" Key bindings
""""""""""
nnoremap ; :

" Line numbers
""""""""""
set relativenumber

" Always show line numbers, but only in current window.
:au WinEnter * :setlocal relativenumber
:au WinLeave * :setlocal norelativenumber

" Absolute Line Numbers in Insert Mode
:au InsertEnter * :set number
:au InsertLeave * :set relativenumber

" Line length and wrapping
""""""""""
set wrap
set textwidth=79
set formatoptions=qrn1

" Windows
""""""""""
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
