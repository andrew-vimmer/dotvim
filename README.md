# Installation
Required packages: `git` `neovim`

```sh
command -v pip && pip install --user pynvim
command -v pip3 && pip3 install --user pynvim
command -v git \
    && git config --global core.editor nvim \
    && git config --global diff.tool "nvim -d" \
    && [ ! -d "$HOME/.config/nvim" ] \
        && git clone https://github.com/andrew-vimmer/dotvim "$HOME/.config/nvim" \
        && command -v nvim && nvim +PlugInstall +qa

```

## Golang
```
if &ft ==# 'go'
    set noexpandtab
    let g:ale_fixers = get(g:, 'ale_fixers', {})
    let g:ale_fixers.go = ['gofmt']
    let g:ale_linters = get(g:, 'ale_linters', {})
    let g:ale_linters.go = ['gobuild']
	let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
	let g:LanguageClient_serverCommands.go = ['go-langserver', '-gocodecompletion']
	nmap <buffer> <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
	nnoremap <buffer> <silent> <Leader>f :call LanguageClient#textDocument_references()<CR>
	nnoremap <buffer> <silent> <Leader>d :call LanguageClient#textDocument_hover()<CR>
endif
```

