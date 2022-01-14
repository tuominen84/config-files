set number
set background=dark
set autoindent
set relativenumber

set incsearch
set hlsearch

set sts=4
set sw=4
set ts=4
set expandtab

set mouse=a

set scrolloff=8

inoremap jk <esc>

nnoremap <C-j> 4<C-e>4j
nnoremap <C-k> 4<C-y>4k

let mapleader = " "

set showcmd

if has('gui_running')
    colorscheme desert
    set guifont=DejaVu\ Sans\ Mono\ 11
endif

au BufRead,BufNewFile *.jou set filetype=scheme


