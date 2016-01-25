
" Technical behaviour corrections.
"
" File encodings.
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1
" Tune time out length in order to use <ESC> mapping for <M-...> combinations.
set notimeout nottimeout
" Not using auto to suppress a SEGV while working on large files.
set regexpengine=2

" Automatically close preview window when completion is done.
autocmd CompleteDone * silent! pclose
" Automatically set file type for *.h files to C, since it defaults to CPP.
autocmd BufNew,BufNewFile,BufRead *.h set filetype=c

" Common behaviour corrections.
"
" Leader key mapping.
let mapleader = ","

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
call plug#begin('~/.vim/plugins')

Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'andrew-vimmer/c-snippets'
Plug 'calmofthestorm/vim-indent-object'
Plug 'embear/vim-localvimrc'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic', {'for': ['c', 'cpp', 'python']}
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

call plug#end()


" Syntax Highlighting and Indentation.
"
syntax on
filetype plugin indent on

" Spelling.
"
" Git commit messages.
autocmd BufRead *.git/COMMIT_EDITMSG set spell
" Mercurial commit messages.
autocmd BufRead *hg-editor* set spell
" Perforce commit messages.
autocmd BufRead /tmp/tmp.*.* set spell


" vim-localvimrc plugin.
"
" NOTE:
"   The configuration makes all local configuration files be loaded without
"   asking or being sandboxed. The reason for such behaviour is that there are
"   plenty of ways to achieve persistence on the system, so I find default
"   settings redundant. If you'd like to debug issues arising from local
"   configuration files, revert these to default or use the
"   `g:localvimrc_debug` instead.
let g:localvimrc_ask = 0
let g:localvimrc_name = ['.vimrc']
let g:localvimrc_sandbox = 0


" CtrlP plugin.
"
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v(\.(git|hg|build))|build$'
let g:ctrlp_map = '<C-p>'
let g:ctrlp_max_files = 0
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'w'

if executable('ag')
    let g:ctrlp_use_caching = 0
    let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
endif


" neocomplete plugin.
"
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif


" UltiSnips plugin.
"
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '.']


" EasyMotion plugin.
"
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_keys = "jfkdhglsienvowmcpqx,z/a;"
let g:EasyMotion_move_highlight = 0
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_use_smartsign_us = 1

nmap <Space> <Plug>(easymotion-sn)
omap <Space> <Plug>(easymotion-tn)
vmap <Space> <Plug>(easymotion-tn)


" Syntastic plugin.
"
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'E'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_error_symbol = 'e'
let g:syntastic_style_warning_symbol = 'w'

let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }

let g:syntastic_c_checkers = ['clang_check']
let g_syntastic_python_checkers = ['python', 'flake8']

let g:syntastic_c_clang_check_post_args = ""

" Error checking with Syntastic.
nnoremap <Leader>e :update<CR>:silent! SyntasticCheck<CR>:silent! Errors<CR>
vnoremap <Leader>e <ESC>:update<CR>:silent! SyntasticCheck<CR>:silent! Errors<CR>gv
" Common reset (highlighting and Syntastic errors).
nnoremap <Leader>r :nohlsearch<CR>:silent! SyntasticReset<CR>
vnoremap <Leader>r <ESC>:nohlsearch<CR>:silent! SyntasticReset<CR>gv


" Ag.vim plugin.
"
let g:ag_highlight = 1

nnoremap <Leader>s :Ag! |
nnoremap <Leader>S :AgBuffer! --smart-case |

" Searching.
"
set incsearch
set hlsearch
set ignorecase
set smartcase


" Yank selected text to the '@/' register and escape newline characters and
" specified substrings.
function! YankSelected(cmdtype)
    let temp = @"

    normal! gvy

    let @" = escape(@", a:cmdtype.'\*')
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @" = temp
endfunction

" Forward search visually selected text using '*' command.
xnoremap * :<C-u>call YankSelected('/')<CR>/<C-R>=@/<CR><CR>N
" Backward search visually selected text using '#' command.
xnoremap # :<C-u>call YankSelected('?')<CR>?<C-R>=@/<CR><CR>n

" Stay on current match.
nnoremap * *N


" UI.
"
set background=dark
" Guide lines.
set colorcolumn=80
" Color scheme.
colorscheme solarized
" Never really found them useful anyway.
set nofoldenable
" Minimal number of screen lines visible above/below cursor.
set scrolloff=3
" Prefer vertical splits on the right.
set splitright
" Disable screen flickering on bell character.
set visualbell t_vb=
set wildmenu

" Automatically resize splits.
autocmd VimResized * wincmd =


" Status line.
"
set statusline=%m%w%h%r\ %f\ %{&fenc!=''?&fenc:&enc}%{&bomb?'\+BOM':''}\,\ %{&ff}\ %=%l/%L\,\ %v\ "
" Show always.
set laststatus=2


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


" Automatically remove whitespace on save.
"
autocmd FileType c,python autocmd BufWritePre <buffer> StripWhitespace


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
set backspace=indent,start
" Break undo sequence on carriage return.
inoremap <CR> <C-g>u<CR>
" Break undo sequence on delete backward word.
inoremap <C-w> <C-g>u<C-w>
" Break undo sequence on delete backward line.
inoremap <C-u> <C-g>u<C-u>

" Yank to the end of a line instead of being a 'yy' alias.
nmap Y y$
" Retain cursor position when yanking from visual mode.
vmap y ygv<ESC>
" Visually select changed or pasted text.
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Remap join to 'M' for Merge.
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
