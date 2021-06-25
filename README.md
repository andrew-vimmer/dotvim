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
# Language Specific Configurations
## Golang
```vim
if &ft ==# 'go'
  setl noet ts=8 sw=8
  let b:ale_linters = {'go': ['golangci-lint']}
  au BufWritePre <buffer> :silent call CocAction('format')
  au BufWritePre <buffer> :silent call CocAction('runCommand', 'editor.action.organizeImport')
  nm <buffer> <silent> <C-]> :call CocAction('jumpDefinition')<CR>
  nn <buffer> <silent> K :call CocAction('doHover')<CR>
  nn <buffer> <silent> <Leader>r :call CocAction('jumpReferences')<CR>
  nn <buffer> <silent> <Leader>i :call CocAction('jumpImplementation')<CR>
endif
```

## Python
```vim
if &ft ==# 'python'
  setl et ts=4 sw=4
  let b:ale_linters = {'python': ['pyre']}
  let b:coc_root_patterns = ['.git', 'venv']
  au BufWritePre <buffer> :silent call CocAction('format')
  au BufWritePre <buffer> :silent call CocAction('runCommand', 'pyright.organizeimports')
  nm <buffer> <silent> <C-]> :call CocAction('jumpDefinition')<CR>
  nn <buffer> <silent> K :call CocAction('doHover')<CR>
  nn <buffer> <silent> <Leader>r :call CocAction('jumpReferences')<CR>
endif
```
