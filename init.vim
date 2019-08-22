scriptencoding utf-8

call plug#begin()
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'dense-analysis/ale'
Plug 'embear/vim-localvimrc'
Plug 'lifepillar/vim-solarized8'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tbodt/deoplete-tabnine', {'do': 'bash install.sh'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
call plug#end()

set fillchars=vert:\ ,eob:\ ,diff:\  listchars=tab:‧\ ,eol:¬
set mouse=a
set statusline=%m%w\ %f
set termguicolors
colorscheme solarized8_flat

function! s:ToggleRulerBuffer() abort
	let b:vimrc_ruler = !get(b:, 'vimrc_ruler', 0)
	if b:vimrc_ruler
		setlocal colorcolumn=79 cursorcolumn list spell
	else
		setlocal nospell nolist nocursorcolumn colorcolumn=
	endif
endfunction
nnoremap <silent> <Leader>* :call <SID>ToggleRulerBuffer()<CR>
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

let g:grepper = {'tools': ['rg', 'grep']}
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

augroup vimrc
	autocmd!
	autocmd BufRead *.git/COMMIT_EDITMSG setlocal spell
	autocmd InsertEnter * call deoplete#enable()
augroup END
