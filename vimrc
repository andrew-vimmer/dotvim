scriptencoding utf-8

" Define a host group for the configuration script.
augroup vimrc
    autocmd!
augroup END

" File encodings.
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1
" No time out for mappings in order to improve stability for remote terminals.
set notimeout nottimeout
" Not using auto to suppress a SEGV while working on large files.
set regexpengine=2

" Leader key mapping.
let g:mapleader = ','

" Simplified command prompt access in normal mode.
nnoremap ; :
" Simplified command prompt access in visual mode.
vnoremap ; :

" Simplified saving in normal mode.
nnoremap s :update<CR>
" Simplified saving in visual mode.
vnoremap s <ESC>:update<CR>gv


" Enable plugins.
"
call plug#begin()

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
    Plug 'Shougo/neocomplete.vim'
    Plug 'Shougo/vimproc.vim', {'do' : 'make'}
endif

Plug 'Chiel92/vim-autoformat'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Lokaltog/vim-easymotion'
Plug 'Quramy/tsuquyomi'
Plug 'SirVer/ultisnips'
Plug 'calmofthestorm/vim-indent-object'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'leafgarland/typescript-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'w0rp/ale'
Plug 'yssl/QFEnter'

call plug#end()


" Local configuration discovery.
"
" NOTE:
"   The settings make all local configuration files be loaded without asking or
"   being sandboxed. The reason for such behaviour is that there are plenty of
"   ways to achieve persistence on the system, so I find default
"   settings redundant. If you'd like to debug issues arising from local
"   configuration files, revert these to default or use the
"   `g:localvimrc_debug` instead.
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0


" Fuzzy file finder.
"
let g:ctrlp_by_filename = 1
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<C-f>'
let g:ctrlp_match_current_file = 1
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}
let g:ctrlp_max_files = 0
let g:ctrlp_mruf_relative = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'w'

if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
endif


" QuickFix window rectifications.
"
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']


" Context free word completion.
"
let g:deoplete#enable_at_startup = 1

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1


" Text snippets.
"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '.']


" Automatic formatting.
"
let g:autoformat_autoindent = 0


" Spelling.
"
augroup Spelling
    autocmd!
    " Git commit messages.
    autocmd BufRead *.git/COMMIT_EDITMSG setlocal spell
    " Mercurial commit messages.
    autocmd BufRead *hg-editor* setlocal spell
    " Perforce commit messages.
    autocmd BufRead /tmp/tmp.*.* setlocal spell
augroup END


" Error checking.
"
let g:ale_enabled = 0 
let g:ale_open_list = 1

let g:ale_linters = {
    \ 'go': 'all',
    \ 'python': 'all',
    \ 'text': 'all',
    \ 'typescript': 'all',
    \}

function! s:CheckForErrors()
    update
    setlocal list
    setlocal spell
    if exists(':ALEEnable')
        ALEEnable
    endif
endfunction
command! CheckForErrors :call <SID>CheckForErrors()

function! s:CommonReset()
    setlocal nolist
    setlocal nospell
    if exists(':ALEDisable')
        ALEDisable
    endif
    redraw!
endfunction
command! CommonReset :nohlsearch|call <SID>CommonReset()

nnoremap <Leader>e :CheckForErrors<CR>
vnoremap <Leader>e <ESC>:CheckForErrors<CR>gv

nnoremap <Leader>r :CommonReset<CR>
vnoremap <Leader>r <ESC>:CommonReset<CR>gv


" Advanced motion operators.
"
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_keys = 'fjdksla;ghtyrueiwoqpvnc,x.z/'
let g:EasyMotion_move_highlight = 0
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_use_smartsign_us = 1

nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)


" Searching.
"
" Highlight previous search matches.
set hlsearch
" Searches are case insensitive.
set ignorecase
" Matches are shown as soon as the pattern is being typed.
set incsearch
" If pattern contains upper case characters search becomes case sensitive.
set smartcase

" Global search operators.
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)


" Copy from `https://github.com/bronson/vim-visual-star-search`.
"
" The reason why not the plugin itself is used here is that it sets an
" undesired mapping, which is hard to override.
function! s:VisualStarSearchSet(cmdtype)
    let temp = @"
    normal! gvy

    let @" = escape(@", a:cmdtype.'\*')
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @/ = substitute(@/, '\[', '\\[', 'g')
    let @/ = substitute(@/, '\~', '\\~', 'g')
    let @" = temp
endfunction

" Forward search visually selected text using `*` command.
xnoremap * :<C-u>call <SID>VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
" Backward search visually selected text using `#` command.
xnoremap # :<C-u>call <SID>VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n
" Stay on current match.
nnoremap * *N


" UI.
"
" Guide lines.
set colorcolumn=80
" Color scheme.
try
    colorscheme solarized8_dark_flat
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme slate
endtry
" Characters to use in `list` mode.
set listchars=tab:!\ ,eol:¬
" Never really found them useful anyway.
set nofoldenable
" Minimal number of screen lines visible above/below cursor.
set scrolloff=3
" Disable screen flickering on bell character.
set visualbell t_vb=
" Display all matching files on tab completion.
set wildmenu

" Automatically close preview window when completion is done.
autocmd vimrc CompleteDone * silent! pclose
" Automatically resize splits.
autocmd vimrc VimResized * wincmd =


" Status line.
"
set statusline=%m%w\ %f%=#\ %l\ "
" Show always.
set laststatus=2


" Spaces and Tabs.
"
" <TAB> characters will be shown as this number of spaces.
set tabstop=4
" <TAB> press will produce spaces instead of actual tabs.
set expandtab
" <TAB> press will produces this number of spaces.
set softtabstop=4
" The number of spaces indentation stands for.
set shiftwidth=4


" Editing.
"
" Line breaks cannot be removed in insert mode.
set backspace=indent,start
" Break undo sequence on carriage return.
inoremap <CR> <C-g>u<CR>
" Break undo sequence on delete backward word.
inoremap <C-w> <C-g>u<C-w>
" Break undo sequence on delete backward line.
inoremap <C-u> <C-g>u<C-u>

" Yank to the end of a line instead of being a `yy` alias.
nmap Y y$
" Retain cursor position when yanking from visual mode.
vmap y ygv<ESC>
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
" Move selected lines downwards and retain selection.
vnoremap J :m '>+1<CR>gv
" Decrease indentation level of selected lines and retain selection.
vnoremap H <gv
" Move selected lines upwards and retain selection.
vnoremap K :m '<-2<CR>gv
" Increase indentation level of selected lines and retain selection.
vnoremap L >gv
