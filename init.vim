scriptencoding utf-8

set fillchars=vert:\ ,eob:\ ,diff:\  listchars=tab:‧\ ,eol:¬
set statusline=%m%w\ %f

nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

function! s:ToggleRulerBuffer() abort
	let b:vimrc_ruler = !get(b:, 'vimrc_ruler', 0)
	if b:vimrc_ruler
		setlocal colorcolumn=79 cursorcolumn list spell
	else
		setlocal nospell nolist nocursorcolumn colorcolumn=
	endif
endfunction
nnoremap <silent> <Leader>* :call <SID>ToggleRulerBuffer()<CR>

call plug#begin()
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'lifepillar/vim-solarized8'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
call plug#end()

set termguicolors
colorscheme solarized8_flat

let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

augroup vimrc
	autocmd!
	autocmd BufRead *.git/COMMIT_EDITMSG setlocal spell
	autocmd InsertEnter * call deoplete#enable()
augroup END

let g:EasyMotion_add_search_history = 0
let g:EasyMotion_smartcase = 1
nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)

let g:grepper = {'tools': ['rg', 'grep']}
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)
