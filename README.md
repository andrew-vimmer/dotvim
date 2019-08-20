# Installation
Required packages: `git`, `curl`

```sh
mkdir -p "$HOME/.local/bin" \
	&& command -v curl \
		&& curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage > "$HOME/.local/bin/nvim" \
	&& chmod u+x "$HOME/.local/bin/nvim"
command -v pip && pip install -U --user pynvim
command -v pip3 && pip3 install -U --user pynvim
command -v git \
	&& git config --global core.editor nvim \
	&& git config --global diff.tool "nvim -d" \
	&& rm -rf "$HOME/.config/nvim" \
		&& git clone https://github.com/avimmer/dotvim "$HOME/.config/nvim" \
		&& command -v nvim && nvim +PlugInstall +qa

```

## Golang
```vim
if &ft ==# 'go'
	setl ts=8 sw=8 noet
	let g:ale_fix_on_save = 1
	let g:ale_fixers = get(g:, 'ale_fixers', {})
	let g:ale_fixers.go = ['goimports']
	let g:ale_lint_on_text_changed = 'never'
	let g:ale_linters = get(g:, 'ale_linters', {})
	let g:ale_linters.go = ['gobuild']
	let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
	let g:LanguageClient_serverCommands.go = ['go-langserver', '-gocodecompletion']
	nm <buffer> <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
	nn <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
	nn <buffer> <silent> <Leader>r :call LanguageClient#textDocument_references()<CR>
endif
```

## YAML
```vim
if &ft ==# 'yaml' || &ft ==# 'json'
	setl ts=2 sw=2
	let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
	let g:LanguageClient_serverCommands.yaml = ['yaml-language-server', '--stdio']
	let settings = json_decode('
	\{
	\	 "yaml": {
	\		 "completion": false,
	\		 "hover": true,
	\		 "validate": true,
	\		 "schemas": {
	\			 "Kubernetes": "/*"
	\		 },
	\		 "format": {
	\			 "enable": true
	\		 }
	\	 },
	\	 "http": {
	\		 "proxyStrictSSL": true
	\	 }
	\}')
	aug LanguageClient_config
		au!
		au User LanguageClientStarted call LanguageClient#Notify(
			\ 'workspace/didChangeConfiguration', {'settings': settings})
	aug END
	nn <buffer> <silent> <Leader>f :call LanguageClient#textDocument_formatting()<CR>
	nn <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
endif
```

