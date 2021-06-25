call plug#begin()
Plug 'dense-analysis/ale'
Plug 'embear/vim-localvimrc'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
call plug#end()

let g:localvimrc_persistent = 2
let g:localvimrc_sandbox = 0

set clipboard=unnamedplus
set fillchars=vert:\ ,eob:\ ,diff:\  listchars=tab:‧\ ,eol:¬
set mouse=a
set statusline=%f\ %m
