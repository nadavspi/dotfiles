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

" utils
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'terryma/vim-multiple-cursors'

" html/css
Plugin 'mattn/emmet-vim'
Plugin 'JulesWang/css.vim'
Plugin 'ap/vim-css-color'
Plugin 'othree/html5.vim'

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

" edit vimrc 
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

nnoremap <tab> %
inoremap <tab> <c-x><c-o>

" Vim fugitive
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gc :Gcommit -m "
nnoremap <leader>gp :Git push<cr>

" edit files relative to current dir
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

" CtrlP
""""""""
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

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
