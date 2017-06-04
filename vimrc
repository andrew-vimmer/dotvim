" File encodings.
set fileencodings=ucs-bom,utf-8,default,cp1251,latin1
" No time out for mappings in order to improve stability for remote terminals.
set notimeout nottimeout
" Not using auto to suppress a SEGV while working on large files.
set regexpengine=2
" Automatically close preview window when completion is done.
autocmd CompleteDone * silent! pclose

" Leader key mapping.
let mapleader = ','

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

Plug 'Chiel92/vim-autoformat'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'Lokaltog/vim-easymotion'
Plug 'Shougo/neocomplete.vim'
Plug 'SirVer/ultisnips'
Plug 'altercation/vim-colors-solarized'
Plug 'calmofthestorm/vim-indent-object'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'mhinz/vim-grepper'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'yssl/QFEnter'

call plug#end()


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


" vim-localvimrc plugin.
"
" NOTE:
"   The settings make all local configuration files be loaded without asking or
"   being sandboxed. The reason for such behaviour is that there are plenty of
"   ways to achieve persistence on the system, so I find default
"   settings redundant. If you'd like to debug issues arising from local
"   configuration files, revert these to default or use the
"   `g:localvimrc_debug` instead.
let g:localvimrc_ask = 0
let g:localvimrc_name = ['.vimrc']
let g:localvimrc_sandbox = 0


" CtrlP plugin.
"
let g:ctrlp_by_filename = 1
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_lazy_update = 10
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


" QFEnter plugin.
"
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-CR>', '<C-s>', '<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']


" neocomplete plugin.
"
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1


" UltiSnips plugin.
"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '.']


" EasyMotion plugin.
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


" Syntastic plugin.
"
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'E'
let g:syntastic_style_error_symbol = 'e'
let g:syntastic_style_warning_symbol = 'w'
let g:syntastic_warning_symbol = 'W'

let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

let g:syntastic_c_checkers = ['clang_check']
let g:syntastic_c_clang_check_post_args = ''
let g:syntastic_go_checkers = ['go', 'govet', 'gofmt']
let g:syntastic_python_checkers = ['python', 'flake8', 'pylint']
let g:syntastic_text_checkers = ['proselint']


function! s:CheckForErrors()
    update
    setlocal spell
    if exists(':SyntasticCheck')
        SyntasticCheck
        Errors
    endif
endfunction
command! CheckForErrors :call <SID>CheckForErrors()

function! s:CommonReset()
    setlocal nospell
    if exists(':SyntasticReset')
        SyntasticReset
    endif
    redraw!
endfunction
command! CommonReset :nohlsearch|call <SID>CommonReset()

" Error checking.
nnoremap <Leader>e :CheckForErrors<CR>
vnoremap <Leader>e <ESC>:CheckForErrors<CR>gv
" Common reset.
nnoremap <Leader>r :CommonReset<CR>
vnoremap <Leader>r <ESC>:CommonReset<CR>gv


" Searching.
"
set hlsearch
set ignorecase
set incsearch
set smartcase

" Global search operation.
nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)


" Copy from 'https://github.com/bronson/vim-visual-star-search'.
"
" The reason why not the plugin itself is used here is that it sets an
" undesired mapping, which's hard to override.
function! s:VisualStarSearchSet(cmdtype)
    let temp = @"
    normal! gvy

    let @" = escape(@", a:cmdtype.'\*')
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @/ = substitute(@/, '\[', '\\[', 'g')
    let @/ = substitute(@/, '\~', '\\~', 'g')
    let @" = temp
endfunction

" Forward search visually selected text using '*' command.
xnoremap * :<C-u>call <SID>VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
" Backward search visually selected text using '#' command.
xnoremap # :<C-u>call <SID>VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n
" Stay on current match.
nnoremap * *N


" UI.
"
set background=dark
" Guide lines.
set colorcolumn=80
" Color scheme.
try
    colorscheme solarized
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme slate
endtry
" Never really found them useful anyway.
set nofoldenable
" Minimal number of screen lines visible above/below cursor.
set scrolloff=3
" Disable screen flickering on bell character.
set visualbell t_vb=
" Display all matching files on tab completion.
set wildmenu

" Automatically resize splits.
autocmd VimResized * wincmd =


" Status line.
"
set statusline=%m%w%r\ %f%=#\ %l\ "
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
