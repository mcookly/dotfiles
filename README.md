# My Dotfiles

It's best to back up one's settings, especially if you often tweak your tools.


## Installation

For each program -- alphabetically listed below -- are the commands needed to install the dotfiles. You will need to set `DOTFILES` to the location of your dotfiles folder for these scripts to work (e.g., `export DOTFILES="$HOME/Users/me"`).

### GNU Emacs

```bash
mkdir ~/.emacs.d # Optional
ln -s $DOTFILES/Emacs/* $HOME/.emacs.d/
```

### Helix

```bash
mkdir ~/.config/helix # Optional
ln -s $DOTFILES/Helix/* $HOME/.config/helix/
```

### iTerm

Use the in-software setting:

*Preferences > General > Preferences > Load preferences from a custom folder or URL*

### VSCodium

```bash
ln -s $DOTFILES/VSCodium/settings.json "$HOME/Library/Application Support/VSCodium/User/settings.json"
```

### Zsh

```bash
ln -s $DOTFILES/Zsh/zshrc $HOME/.zshrc
```