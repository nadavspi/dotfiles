call plug#begin('~/.config/nvim/plugged')

" Plugins
""""""""""

" aesthetic
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'reedes/vim-thematic'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'morhetz/gruvbox'
Plug 'romainl/flattened'
Plug 'whatyouhide/vim-gotham'

" tpope
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-rails'

" utils
" Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'thinca/vim-qfreplace'
Plug '907th/vim-auto-save'
Plug 'editorconfig/editorconfig-vim'
Plug 'neomake/neomake'
Plug 'rking/ag.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'cloudhead/neovim-fuzzy'
Plug 'junegunn/fzf.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'
Plug 'godlygeek/tabular'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'bronson/vim-trailing-whitespace'
Plug 'AndrewRadev/sideways.vim'

" frontend
Plug 'mattn/emmet-vim'
Plug 'JulesWang/css.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'sbdchd/neoformat'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'mxw/vim-jsx'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'othree/es.next.syntax.vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'carlitux/deoplete-ternjs'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install -g tern' }

call plug#end()

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Shougo/denite.nvim'
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" General
""""""""""
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set number
set ruler
set backspace=indent,eol,start
let mapleader = "\<Space>"
set visualbell
" for autosave and to show tern argument hints more quickly
set updatetime=1000
set noshowmode

set nobackup
set noswapfile

let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1 
set backupcopy=yes

" persist undo
set undofile

" automatically re-read files that have been changed outside of vim
set autoread

" cursorline on current window only
:au WinEnter * :setlocal cursorline
:au WinLeave * :setlocal nocursorline

" highlight 81st column of wide lines
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P"

inoremap <C-e> <Esc>A

let g:UltiSnipsUsePythonVersion = 2 

" Filetypes
""""""""""
autocmd BufNewFile,BufRead *.phtml set filetype=phtml
autocmd BufNewFile,BufRead *.php set filetype=phtml
autocmd BufNewFile,BufReadPost *.txt set filetype=markdown

autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat

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

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
" use global `tern`
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" Tern
nnoremap <silent> <leader>d :TernDef<CR>

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif
autocmd FileType javascript set formatprg=prettier\ --stdin\ --trailing-comma\ es5\ --single-quote
let g:used_javascript_libs = 'jquery,react'

" Use tab for autocomplete or indent
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" neomake
autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_html_enabled_makers = [] 

" Abbreviations
""""""""""
abbreviate lenght length
abbreviate dont' don't
iabbrev target="_blank" target="_blank" rel="noopener"


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

" nnoremap <tab> %
" inoremap <tab> <c-x><c-o>

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

" fzf
fun! s:fzf_root()
  let path = finddir(".git", expand("%:p:h").";")
  return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfun

nnoremap <silent> <C-p> :exe 'GFiles ' . <SID>fzf_root()<CR>
nnoremap <leader>b :Buffers<cr>
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

nnoremap <silent> <leader>ag :call SearchWordWithAg()<CR>
vnoremap <silent> <leader>ag :call SearchVisualSelectionWithAg()<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  let old_clipboard = &clipboard
  set clipboard&
  normal! ""gvy
  let selection = getreg('"')
  call setreg('"', old_reg, old_regtype)
  let &clipboard = old_clipboard
  execute 'Ag' selection
endfunction

" Emmet
" let g:user_emmet_leader_key = '<c-e>'
" makes emmet work with tab but breaks completion 
" let g:user_emmet_expandabbr_key='<Tab>'
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" Tabs
nnoremap <leader>1 1gt<cr>
nnoremap <leader>2 2gt<cr>
nnoremap <leader>3 3gt<cr>
nnoremap <leader>4 4gt<cr>
nnoremap <leader>5 5gt<cr>
nnoremap <leader>6 6gt<cr>
nnoremap <leader>7 7gt<cr>
nnoremap <leader>8 8gt<cr>

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
nnoremap <leader>ww <C-w>v<C-w>l
nnoremap <leader>wo :only<cr>
nnoremap <leader>wc :close<cr>
nnoremap <leader>v <C-w>
set splitbelow
set splitright

" Airline
""""""""""
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=1
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c'],
    \ [ 'warning' ]
    \ ]

" Ag / The Silver Searcher
""""""""
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
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

let g:jsx_ext_required = 0

" Thematic
""""""""
" let g:gruvbox_italic=1
" highlight Comment cterm=italic
let g:thematic#theme_name = 'gruvbox_dark'
let g:thematic#defaults = {
      \ 'background': 'dark',
      \ 'laststatus': 2,
      \ 'ruler': 0,
\ }
let g:thematic#themes = {
      \ 'flattened_dark' : {
      \ 'colorscheme': 'flattened_dark',
      \ 'background': 'dark',
      \ 'airline-theme': 'solarized',
      \ },
      \ 'flattened_light' : {
      \ 'colorscheme': 'flattened_light',
      \ 'background': 'light',
      \ 'airline-theme': 'solarized',
      \ },
      \ 'gruvbox_dark' : {
      \ 'colorscheme': 'gruvbox',
      \ 'background': 'dark',
      \ 'airline-theme': 'gruvbox',
      \ },
      \ 'gruvbox_light' : {
      \ 'colorscheme': 'gruvbox',
      \ 'background': 'light',
      \ 'airline-theme': 'gruvbox',
      \ },
      \ 'tomorrow' : {
      \ 'colorscheme': 'Tomorrow-Night-Eighties',
      \ 'background': 'dark',
      \ 'airline-theme': 'tomorrow',
      \ },
      \ 'gotham' : {
      \ 'colorscheme': 'gotham',
      \ 'background': 'dark',
      \ 'airline-theme': 'gotham',
      \ },
  \ }

" vim-textobj-user (custom text objects)
""""""""""""""""""""""""""""""""""""""""

call textobj#user#plugin('php', {
\   'code': {
\     'pattern': ['<?php\>', '?>'],
\     'select-a': 'aP',
\     'select-i': 'iP',
\   },
\ })

nnoremap <Leader>< :SidewaysLeft<CR>
nnoremap <Leader>> :SidewaysRight<CR>

" Colemak stuff
nnoremap n j
nnoremap e k
nnoremap i l
nnoremap u i
nnoremap l u
nnoremap k n
nnoremap K N
vnoremap n j
vnoremap e k
vnoremap i l
" had to fix terminfo for this one (https://github.com/neovim/neovim/issues/2048#issuecomment-78045837)
nnoremap <C-h> <C-w><C-h>
nnoremap <C-n> <C-w><C-j>
nnoremap <C-e> <C-w><C-k>
nnoremap <C-i> <C-w><C-l>
