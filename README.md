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
