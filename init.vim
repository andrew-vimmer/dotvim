scriptencoding utf-8

" Define a host group for the configuration script.
augroup vimrc
    autocmd!
augroup END

" Simplified command prompt access in normal mode.
nnoremap ; :
" Simplified command prompt access in visual mode.
vnoremap ; :

" <TAB> will produce spaces and will be shown as 4 spaces.
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" Searches are case insensitive unless pattern contains upper case characters.
set ignorecase smartcase
" Character markers.
set fillchars=vert:\ ,eob:\  listchars=tab:‧\ ,eol:¬
" Status line shows modified, preview flag and file path, and is shown always.
set statusline=%m%w\ %f laststatus=2
" Line breaks cannot be removed in insert mode.
set backspace=indent,start
" Break undo sequence on carriage return.
inoremap <CR> <C-g>u<CR>
" Break undo sequence on delete backward word.
inoremap <C-w> <C-g>u<C-w>
" Break undo sequence on delete backward line.
inoremap <C-u> <C-g>u<C-u>

" Visually select changed or pasted text.
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'
" Remap join to `M` for Merge.
nnoremap M J
" Move line under cursor downwards.
nnoremap J :m .+1<CR>
" Increase indentation level of the line under cursor.
nnoremap H <<
" Move line under cursor upwards.
nnoremap K :m .-2<CR>
" Decrease indentation level of the line under cursor.
nnoremap L >>
" Remap visual join to `M` for Merge.
vnoremap M v_J
" Move selected lines downwards and retain selection.
vnoremap J :m '>+1<CR>gv
" Decrease indentation level of selected lines and retain selection.
vnoremap H <gv
" Move selected lines upwards and retain selection.
vnoremap K :m '<-2<CR>gv
" Increase indentation level of selected lines and retain selection.
vnoremap L >gv

" Automatically close preview window when completion is done.
autocmd vimrc CompleteDone * silent! pclose
" Automatically resize splits.
autocmd vimrc VimResized * wincmd =

" Leader key mapping.
let g:mapleader = ','

function! s:ToggleRulerBuffer() abort
    let b:vimrc_ruler = !get(b:, 'vimrc_ruler', 0)
    if b:vimrc_ruler
        setlocal colorcolumn=79
        setlocal cursorcolumn
        setlocal list
        setlocal spell
    else
        setlocal colorcolumn=
        setlocal nocursorcolumn
        setlocal nospell
        setlocal nolist
    endif
endfunction
nnoremap <silent> <Leader><Leader> :call <SID>ToggleRulerBuffer()<CR>

" Enable plugins.
call plug#begin()
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'SirVer/ultisnips'
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

" Color scheme.
set background=dark
set termguicolors
colorscheme solarized8_flat

" Local configuration discovery.
let g:localvimrc_persistent = 1
let g:localvimrc_sandbox = 0

" Context free word completion.
autocmd vimrc InsertEnter * call deoplete#enable()

" Text snippets.
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '.']

" Spelling for Git commit messages.
autocmd vimrc BufRead *.git/COMMIT_EDITMSG setlocal spell

" Error checking and LSP client.
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights=0
let g:ale_set_signs=0

" Advanced motion operators.
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = 'fjdksla;ghrueiwoqptybvncm,x.z/'
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_use_smartsign_us = 1
nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)

" Global search operators.
let g:grepper = {}
let g:grepper.tools = ['rg', 'grep']
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

" Copy from `https://github.com/bronson/vim-visual-star-search`.
function! s:VisualStarSearchSet(cmdtype)
    let l:temp = @"
    normal! gvy
    let @" = escape(@", a:cmdtype.'\*')
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @/ = substitute(@/, '\[', '\\[', 'g')
    let @/ = substitute(@/, '\~', '\\~', 'g')
    let @" = l:temp
endfunction
" Forward search visually selected text using `*` command.
xnoremap <silent> * :<C-u>call <SID>VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
" Backward search visually selected text using `#` command.
xnoremap <silent> # :<C-u>call <SID>VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n
" Ignore the ignorecase option, stay on current match.
nnoremap <silent> * :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>nN
nnoremap <silent> g* :let @/='\C' . expand('<cword>')<CR>:let v:searchforward=1<CR>nN
" Ignore the ignorecase option, move to the next match.
nnoremap <silent> # :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n
nnoremap <silent> g# :let @/='\C' . expand('<cword>')<CR>:let v:searchforward=0<CR>n

