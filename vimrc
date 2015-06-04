
" Technical behaviour corrections.
"
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1| " File encodings.
set notimeout nottimeout| " Tune time out length in order to use <ESC> mapping for <M-...> combinations.
set regexpengine=2 " Not using auto to suppress a SEGV while working on large files.

autocmd CompleteDone * pclose| " Automatically close preview window when completion is done.
autocmd BufNew,BufNewFile,BufRead *.h set filetype=c| " Automatically set filetype for *.h files to C, since it defaults to CPP.

" Common behaviour corrections.
"
let mapleader = "," " Leader key mapping.

nnoremap ; :| " Simplified command prompt access in normal mode.
vnoremap ; :| " Simplified command prompt access in normal mode.

nnoremap s :update<CR>| " Simplified saving in normal mode.
nnoremap S :update<CR>| " Simplified saving in normal mode (typo guard).
vnoremap s <ESC>:update<CR>gv| " Simplified saving in visual mode.
vnoremap S <ESC>:update<CR>gv| " Simplified saving in visual mode (typo guard).


" Enable plugins.
"
call plug#begin('~/.vim/plugins')

Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/syntastic', { 'for': ['c', 'cpp', 'python'] }
Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'Lokaltog/vim-easymotion'
Plug 'osyo-manga/vim-marching', { 'for': ['c', 'cpp'] }
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Shougo/vimproc.vim'
Plug 'vim-scripts/a.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'andrew-vimmer/c-snippets'
Plug 'calmofthestorm/vim-indent-object'
Plug 'bronson/vim-visual-star-search'

call plug#end()


" Syntax Highlighting and Indentation.
"
syntax on
filetype plugin indent on

" Spelling.
"
autocmd BufRead *.git/COMMIT_EDITMSG set spell
autocmd BufRead *hg-editor* set spell


" CtrlP plugin.
"
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_custom_ignore = '\v(\.(git|hg|build))|build$'


" neocomplete plugin.
"
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif


" UltiSnips plugin.
"
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "."]


" EasyMotion plugin.
"
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_keys = "jfkdhglsienvowmcpqx,z/a;"

nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)


" vim-marching plugin.
"
let g:marching_enable_neocomplete = 1
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'


" Syntastic plugin.
"
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "**"
let g:syntastic_warning_symbol = "*"
let g:syntastic_style_error_symbol = "*"
let g:syntastic_style_warning_symbol = "*"

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

let g:syntastic_c_checkers = ["clang_check"]
let g_syntastic_python_checkers = ["python", "flake8"]

let g:syntastic_c_clang_check_post_args = ""

" Error checking with Syntastic.
nnoremap <Leader>e :update<CR>:SyntasticCheck<CR>:Errors<CR>
vnoremap <Leader>e <ESC>:update<CR>:SyntasticCheck<CR>:Errors<CR>gv
" Common reset (highlighting and Syntastic errors).
nnoremap <Leader>r :nohlsearch<CR>:SyntasticReset<CR>
vnoremap <Leader>r <ESC>:nohlsearch<CR>:SyntasticReset<CR>gv


" Searching.
"
set incsearch
set hlsearch
set ignorecase
set smartcase


" UI.
"
set mouse=nv " Mouse is enabled in NORMAL and VISUAL modes.
set nofoldenable " Never really found them useful anyway.
set paste " Enable paste mode.
set scrolloff=3 " Minimal number of screen lines visible above/below cursor.
set splitright " Prefer vertical splits on the right.
set visualbell t_vb=
set wildmenu

autocmd VimResized * wincmd = " Automatically resize splits.


" Color scheme.
"
set background=dark
colorscheme solarized

highlight SpellBad cterm=bold,undercurl ctermfg=9
highlight SpellCap cterm=bold,undercurl ctermfg=3
highlight SyntasticWarningSign cterm=bold ctermfg=3
highlight SignColumn ctermbg=0
highlight VertSplit ctermbg=0 ctermfg=0
highlight NonText ctermbg=0 ctermfg=0
highlight StatusLineNC cterm=NONE


" Guidelines.
"
set colorcolumn=80,81,82,83,84,85


" Statusline.
"
highlight User1 cterm=reverse,bold ctermfg=3
highlight User2 cterm=reverse,bold

set statusline=%1*%m%*\ %f,\ %{&fenc!=''?&fenc:&enc}%{&bomb?'\+BOM':''}\,\ %{&ff}\ %r%h%w%=%2*%l%*/%L\,\ %2*%v%*\ "
set laststatus=2 " Show always.


" Enable mode-dependent cursor in mintty.
"
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"


" Tab navigation.
"
nnoremap <ESC>n :tabnext<CR>
nnoremap <ESC>p :tabprevious<CR>
nnoremap <ESC>N :tabmove +1<CR>
nnoremap <ESC>P :tabmove -1<CR>
nnoremap <ESC>t :tabnew<CR>
nnoremap <ESC>w :tabclose<CR>


" Window navigation.
"
nnoremap <ESC>j <C-w>j
nnoremap <ESC>h <C-w>h
nnoremap <ESC>k <C-w>k
nnoremap <ESC>l <C-w>l
nnoremap <ESC>J <C-w>J
nnoremap <ESC>H <C-w>H
nnoremap <ESC>K <C-w>K
nnoremap <ESC>L <C-w>L
nnoremap <ESC>v <C-w>v
nnoremap <ESC>s <C-w>s


" File navigation.
"
nnoremap <ESC>o :A<CR> " Switches between header and source files, requires 'a.vim'.
nnoremap <ESC>O :AV<CR> " Open source/header in a new vertical split, requires 'a.vim'.


" Automatically remove whitespace on save.
"
autocmd FileType c,python autocmd BufWritePre <buffer> StripWhitespace


" Python debugging.
"
autocmd FileType python nnoremap <Leader><Leader>d :!python -m pudb.run % |
autocmd FileType python nnoremap <Leader><Leader>r :!python % |


" Spaces and Tabs.
"
set tabstop=4 " <TAB> characters will be viewed as this number of spaces.
set expandtab " <TAB> press will produce spaces instead of actual tabs.
set softtabstop=4 " <TAB> press will produces this number of spaces.
set shiftwidth=4 " The number of spaces indentation stands for.


" Editing.
"
set backspace=indent,start
inoremap <CR> <C-g>u<CR>| " Break undo sequence on carriage return.
inoremap <C-w> <C-g>u<C-w>| " Break undo sequence on delete backward word.
inoremap <C-u> <C-g>u<C-u>| " Break undo sequence on delete backward line.

nmap Y y$| " Yank to the end of a line instead of being a 'yy' alias.
vmap y ygv<ESC>| " Retain cursor position when yanking from visual mode.
nnoremap * *N| " Stay on the current match.
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]' " Visually select changed or pasted text.

nnoremap M :m .+1<CR>| " Move line under cursor downwards.
nnoremap H <<| " Increase indentation level of the line under cursor.
nnoremap K :m .-2<CR>| " Move line under cursor upwards.
nnoremap L >>| " Decrease indentation level of teh line under cursor.
vnoremap M :m '>+1<CR>gv| " Move selected lines downwards and retain selection.
vnoremap H <gv| " Decrease indentation level of selected lines and retain selection.
vnoremap K :m '<-2<CR>gv| " Move selected lines upwards and retain selection.
vnoremap L >gv| " Increase indentation level of selected lines and retain selection.
