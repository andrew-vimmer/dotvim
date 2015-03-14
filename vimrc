
" Not using auto to suppress a SEGV while working on large files.
set regexpengine=2

" File encodings.
"
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1

" Enable Pathogen.
"
execute pathogen#infect()

" Leader key mapping.
"
let mapleader = ","

" Syntax Highlighting and Indentation. 
"
syntax on
filetype plugin indent on

" Spelling.
"
autocmd BufRead *.git/COMMIT_EDITMSG set spell
autocmd BufRead *hg-editor* set spell

" Automatically set filetype for *.h files to C, since it defaults to CPP.
"
autocmd BufNew,BufNewFile,BufRead *.h set filetype=c

" CtrlP plugin.
"
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_switch_buffer = 0

" neocomplete plugin.
"
let g:neocomplete#enable_at_startup = 1

" jedi-vim plugin.
"
autocmd FileType python setlocal omnifunc=jedi#completions

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#rename_command = "" 
let g:jedi#show_call_signatures = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" UltiSnips plugin.
"
let g:UltiSnipsEditSplit = "horizontal"
let g:UltiSnipsSnippetDirectories = ["UltiSnips"]

" EasyMotion plugin.
"
nmap ? :nohlsearch<CR>
nmap <Leader>/ <Plug>(easymotion-sn)
omap <Leader>/ <Plug>(easymotion-tn)
vmap <Leader>/ <Plug>(easymotion-tn)

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

let g:syntastic_c_checkers = ["clang_check"]
let g_syntastic_python_checkers = ["python", "flake8"]

let g:syntastic_c_clang_check_post_args = ""

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

" Spaces and Tabs.
"
set tabstop=4 " <TAB> characters will be viewed as this number of spaces.
set expandtab " <TAB> press will produce spaces instead of actual tabs.
set softtabstop=4 " <TAB> press will produces this number of spaces.
set shiftwidth=4 " The number of spaces indentation stands for.

" Searching.
"
set incsearch
set hlsearch
set ignorecase
set smartcase

" UI.
"
set wildmenu
set nofoldenable " Never really found them useful anyway.
set visualbell t_vb=
set mouse=a
set splitright " Prefer vertical splits on the right.
autocmd VimResized * wincmd = " Automatically resize splits.

" Statusline.
"
highlight User1 cterm=reverse,bold ctermfg=3
highlight User2 cterm=reverse,bold 

set statusline=%1*%m%*\ %f,\ %{&fenc!=''?&fenc:&enc}%{&bomb?'\+BOM':''}\,\ %{&ff}\ %r%h%w%=%2*%l%*/%L\,\ %2*%v%*\ "
set laststatus=2 " Show always. 

" Tune time out length in order to use <ESC> mapping for <M-...> combinations.
"
set notimeout nottimeout

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
nnoremap <ESC>Q ZQ
nnoremap <ESC>v <C-w>v
nnoremap <ESC>s <C-w>s

" File navigation.
"
nnoremap <ESC>o :A<CR> " Switches between header and source files, requires 'a.vim'.
nnoremap <ESC>O :AV<CR> " Open source/header in a new vertical split, requires 'a.vim'.

" Automatically remove whitespace on save.
"
autocmd FileType c,python autocmd BufWritePre <buffer> :%s/\s\+$//e | :nohlsearch

" Python debugging.
"
autocmd FileType python nnoremap <Leader><Leader>d :!python -m pudb.run % |
autocmd FileType python nnoremap <Leader><Leader>r :!python % |

" Editing.
"
set backspace=indent,start

vmap y ygv<ESC> " Retain selection after yanking.

vmap < <gv
vmap > >gv

nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]' " Visually select changed or pasted text.

nmap * *N " Stay on the current match.
