scriptencoding utf-8

call plug#begin()
Plug 'dense-analysis/ale'
Plug 'embear/vim-localvimrc'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
call plug#end()

set fillchars=vert:\ ,eob:\ ,diff:\  listchars=tab:‧\ ,eol:¬
set mouse=a
set statusline=%f\ %m

let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0
