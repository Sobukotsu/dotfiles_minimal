" ~/.vimrc
"
" Minimal vim config: builtin options and one builtin colorscheme only.
" No plugin manager, no plugins — safe on any stock vim (and nvim, which
" reads this file as well).

set nocompatible
set nobackup
set noswapfile
set encoding=utf-8

set number
set cursorline
set showcmd
set wildmenu
set laststatus=2

set hlsearch
set ignorecase
set smartcase
set incsearch

set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

if has('mouse')
  set mouse=a
endif
if has('clipboard')
  set clipboard=unnamed
endif

silent! colorscheme default
