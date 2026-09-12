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
set relativenumber
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

" Syntax highlighting and per-filetype indent/settings.
if has('syntax')
  syntax on
endif
if has('autocmd')
  filetype plugin indent on
endif

" Cycle through :make/:grep results.
if has('quickfix')
  nnoremap ]q :cnext<CR>
  nnoremap [q :cprev<CR>
endif

silent! colorscheme default
