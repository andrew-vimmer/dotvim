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
  let g:ale_lint_on_text_changed = 'never'
  let b:ale_linters = {'go': ['gobuild']}
  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
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
  let b:ale_fixers = {'python': ['black']}
  let b:ale_fix_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let b:ale_linters = {'python': ['pyre', 'prospector']}
  nm <buffer> <silent> <C-]> :call CocAction('jumpDefinition')<CR>
  nn <buffer> <silent> K :call CocAction('doHover')<CR>
  nn <buffer> <silent> <Leader>r :call CocAction('jumpReferences')<CR>
endif
```
