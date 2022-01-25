
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
"Plugin 'kien/ctrlp.vim'
"Plugin 'bling/vim-airline'
" Plugin 'davidhalter/jedi-vim'
"Plugin 'scrooloose/syntastic'
" Markdown things
"Plugin 'godlygeek/tabular'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'michaeljsmith/vim-indent-object'
"Plugin 'jiangmiao/auto-pairs'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
 
colorscheme gruvbox
" set guifont=DejaVu\ Sans\ Mono:h22
set gfn=Monaco:h14
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set relativenumber
set number
set cursorline
set autoindent
set smartindent
set scrolloff=8

filetype plugin on
syntax on
set modeline

set background=dark


set clipboard=unnamed

set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

inoremap jk <ESC>
vnoremap jk <ESC>
map <C-h> :noh<CR>

set sts=4
set sw=4

let g:syntastic_python_checkers=['pyflakes']

set path+=**
set wildmenu

let g:netrw_banner=0
let g:netrw_browse_split=4	" open in prior window
let g:netrw_altv=1		" open splits to right 
let g:netrw_liststyle=3		" tree view

autocmd Syntax markdown normal zR

set mouse=a

iabbrev <expr> ddt strftime("%Y-%m-%d %a")
