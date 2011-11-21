set nocompatible

set nowrap
set number

syntax enable
set foldmethod=syntax
colorscheme molokai 
set t_Co=256

filetype plugin on
filetype indent on

autocmd! bufwritepost vimrc source ~/.vimrc

set wildmenu
set ruler
set backspace=indent,eol,start
set ignorecase 
set smartcase

set hlsearch 
set incsearch 

set cmdheight=2
set history=1000
set title
set magic 

set showmatch 

set shiftwidth=8
set tabstop=8
set smarttab

set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P
set laststatus=2

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
