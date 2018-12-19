scriptencoding utf-8

" Define a host group for the configuration script.
augroup vimrc
    autocmd!
augroup END

" No time out for mappings in order to improve stability on remote terminals.
set notimeout nottimeout

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

" Simplified search reset in normal mode.
nmap <Leader><Leader> :nohlsearch<CR>
" Simplified search reset in visual mode.
vmap <Leader><Leader> :nohlsearch<CR>


" Enable plugins.
"
call plug#begin()

Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'SirVer/ultisnips'
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


" Text snippets.
"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', '.']


" Spelling.
"
augroup vimrc_spelling
    autocmd!
    " Git commit messages.
    autocmd BufRead *.git/COMMIT_EDITMSG setlocal spell
    " Mercurial commit messages.
    autocmd BufRead *hg-editor* setlocal spell
    " Perforce commit messages.
    autocmd BufRead /tmp/tmp.*.* setlocal spell
augroup END


" Error checking and LSP client.
"
let g:ale_lint_on_text_changed = 'never'
let g:ale_linters = {}
let g:ale_linters.go = ['gometalinter', 'golangserver']
let g:ale_set_highlights=0
let g:ale_set_signs=0

nmap <C-]> <Plug>(ale_go_to_definition)
nmap <Leader>d <Plug>(ale_hover)


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
command! ToggleRulerBuffer call <SID>ToggleRulerBuffer()

nnoremap <Leader>r :ToggleRulerBuffer<CR>
vnoremap <Leader>r <ESC>:ToggleRulerBuffer<CR>gv


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
let g:grepper = {}
let g:grepper.tools = ['rg', 'ag', 'grep']

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)


" Copy from `https://github.com/bronson/vim-visual-star-search`.
"
" The reason why not the plugin itself is used here is that it sets an
" undesired mapping, which is hard to override.
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
xnoremap * :<C-u>call <SID>VisualStarSearchSet('/')<CR>/<C-R>=@/<CR><CR>N
" Backward search visually selected text using `#` command.
xnoremap # :<C-u>call <SID>VisualStarSearchSet('?')<CR>?<C-R>=@/<CR><CR>n
" Ignore the ignorecase option, stay on current match.
nnoremap <silent> * :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>nN
nnoremap <silent> g* :let @/='\C' . expand('<cword>')<CR>:let v:searchforward=1<CR>nN
" Ignore the ignorecase option, move to the next match.
nnoremap <silent> # :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n
nnoremap <silent> g# :let @/='\C' . expand('<cword>')<CR>:let v:searchforward=0<CR>n


" UI.
"
" Background color mode.
set background=dark
" Color scheme.
try
    colorscheme solarized8_flat
    if has('termguicolors')
        set termguicolors
    endif
catch /^Vim\%((\a\+)\)\=:E185/
    colorscheme slate
endtry
" Suppress vertical separators and empty line markers at the end of a buffer.
set fillchars=vert:\ ,eob:\ |
" Characters to use in `list` mode.
set listchars=tab:‧\ ,eol:¬
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
set statusline=%m%w\ %f
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
