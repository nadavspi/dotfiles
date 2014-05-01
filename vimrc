set nocompatible
syntax on
set number
filetype plugin indent on
set backspace=indent,eol,start

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4


set relativenumber

" Always show line numbers, but only in current window.
:au WinEnter * :setlocal relativenumber
:au WinLeave * :setlocal norelativenumber

" Absolute Line Numbers in Insert Mode
:au InsertEnter * :set number
:au InsertLeave * :set relativenumber
