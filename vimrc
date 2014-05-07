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
Plugin 'JulesWang/css.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'othree/html5.vim'
Plugin 'christoomey/vim-tmux-navigator'

call vundle#end()
filetype plugin indent on

" General
""""""""""
colorscheme desert
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
set shiftwidth=2
set tabstop=2

" Search
""""""""""
set ignorecase
set smartcase

" Unset the 'last search pattern' highlight by hitting enter
nnoremap <CR> :noh<CR>

" Key bindings
""""""""""
nnoremap ; :
nnoremap <tab> %

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

" Tmux / Vim Split Windows 
""""""""""
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

  let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
  let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
  let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te

  nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
  nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
  nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
  nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
else
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l
endif
