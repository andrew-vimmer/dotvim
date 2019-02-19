# Installation
Required packages: `git` `neovim`

Optional packages: `python2` `python3` `pip` `pip3`

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

