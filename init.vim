scriptencoding utf-8

" Define a host group for the configuration script.
augroup vimrc
    autocmd!
augroup END

" Simplified command prompt access in normal and visual modes.
nnoremap ; :
vnoremap ; :

" <TAB> will produce spaces and will be shown as 4 spaces.
set tabstop=4 shiftwidth=4 expandtab
" Character markers.
set fillchars=vert:\ ,eob:\  listchars=tab:‧\ ,eol:¬
" Status line shows modified, preview flag and file path, and is shown always.
set statusline=%m%w\ %f

" Visually select changed or pasted text.
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

" https://github.com/bronson/vim-visual-star-search
function! s:VisualStarSearchSet(cmdtype)
    let l:temp = @"
    normal! gvy
    let @" = escape(@", a:cmdtype.'\*')
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @/ = substitute(@/, '\[', '\\[', 'g')
    let @/ = substitute(@/, '\~', '\\~', 'g')
    let @" = l:temp
endfunction
xnoremap <silent> * :<C-u>call <SID>VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>
xnoremap <silent> # :<C-u>call <SID>VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>

call plug#begin()
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'easymotion/vim-easymotion'
Plug 'embear/vim-localvimrc'
Plug 'lifepillar/vim-solarized8'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
call plug#end()

set termguicolors
colorscheme solarized8_flat

" Local configuration discovery.
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

" Context free word completion.
autocmd vimrc InsertEnter * call deoplete#enable()
" Automatically close preview window when completion is done.
autocmd vimrc CompleteDone * silent! pclose
" Spelling for Git commit messages.
autocmd vimrc BufRead *.git/COMMIT_EDITMSG setlocal spell

" Advanced motion operators.
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_smartcase = 1
nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)

" Global search operators.
let g:grepper = {'tools': ['rg', 'grep']}
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)
