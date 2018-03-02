
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'davidhalter/jedi-vim'

Plugin 'scrooloose/syntastic'
" Markdown things
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'effi/vim-OpenFoam-syntax'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'

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

" set working directory to current file directory
autocmd BufEnter * lcd %:p:h

autocmd FileType python set ai sw=4 ts=4 sta et fo=croql cc=115
colorscheme gruvbox
" colorscheme solarized

" Vim saves and restores folds when a file is closed and re-opened
au BufWinLeave * mkview
au BufWinEnter * silent loadview

" set guifont=DejaVu\ Sans\ Mono:h22
" set gfn=Monaco:h14
set guifont=DejaVu\ LGC\ Sans\ Mono\ 11
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number
set cursorline
set autoindent

filetype plugin on
syntax on
set modeline

set background=dark

inoremap jk <ESC>

set clipboard=unnamed

set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

inoremap jk <ESC>
map <C-n> :NERDTreeToggle<CR>
map <C-h> :noh<CR>
map <C-b> :CtrlPBuffer<CR>

let g:syntastic_python_checkers=['pyflakes']
set sts=4
set sw=4
set mouse=a


