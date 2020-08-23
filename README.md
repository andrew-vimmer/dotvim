# Installation
Required packages: `git`, `curl`, `python3-pip`

```sh
curl -fL https://github.com/neovim/neovim/releases/download/stable/nvim.appimage \
  --create-dirs -o "$HOME/.local/bin/nvim" \
  && chmod u+x "$HOME/.local/bin/nvim" \
  && pip3 install -U --user pynvim \
  && git config --global core.editor nvim \
  && git config --global diff.tool "nvim -d" \
  && rm -rf "$HOME/.config/nvim" \
    && git clone https://github.com/avimmer/dotvim "$HOME/.config/nvim" \
    && nvim +PlugInstall +qa

```

## Golang
```vim
if &ft ==# 'go'
  let g:ale_fix_on_save = 1
  let g:ale_fixers = get(g:, 'ale_fixers', {})
  let g:ale_fixers.go = ['goimports']
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_linters = get(g:, 'ale_linters', {})
  let g:ale_linters.go = ['gobuild']
  let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
  let g:LanguageClient_serverCommands.go = ['gopls', 'serve']
  nm <buffer> <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
  nn <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
  nn <buffer> <silent> <Leader>r :call LanguageClient#textDocument_references()<CR>
  nn <buffer> <silent> <Leader>i :call LanguageClient#textDocument_implementation()<CR>
endif
```

## Python
```vim
if &ft ==# 'python'
  setl ts=4 sw=4 et
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_linters = get(g:, 'ale_linters', {})
  let g:ale_linters.python = ['pylama']
  let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
  let g:LanguageClient_serverCommands.python = ['pyls']
  nm <buffer> <silent> <C-]> :call LanguageClient#textDocument_definition()<CR>
  nn <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>
  nn <buffer> <silent> <Leader>r :call LanguageClient#textDocument_references()<CR>
  let settings = json_decode('
  \{
  \  "pyls": {
  \    "plugins": {
  \      "mccabe": {
  \        "enabled": false
  \      },
  \      "pycodestyle": {
  \        "enabled": false
  \      },
  \      "pydocstyle": {
  \        "enabled": false
  \      },
  \      "pyflakes": {
  \        "enabled": false
  \      },
  \      "pylint": {
  \        "enabled": false
  \      }
  \    }
  \  }
  \}')
  augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call LanguageClient#Notify(
      \ 'workspace/didChangeConfiguration', {'settings': settings})
  augroup END
endif
```
