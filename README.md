# My Dotfiles

It's best to back up one's settings, especially if you often tweak your tools.


## Installation

For each program -- alphabetically listed below -- are the commands needed to install the dotfiles. You will need to set `DOTFILES` to the location of your dotfiles folder for these scripts to work (e.g., `export DOTFILES="$HOME/Users/me"`).

### Git

```bash
mkdir ~/.config/git # Optional
ln -s $DOTFILES/Git/config $HOME/.gitconfig
ln -s $DOTFILES/Git/ignore $HOME/.gitignore_global
```

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

### Kitty

```bash
mkdir ~/.config/kitty # Optional
ln -s $DOTFILES/Kitty/* $HOME/.config/kitty/
```

### Skim

Skim cannot read a file alias, so you will have to copy things around (or hard link).

To copy:

```bash
cp -f $HOME/Library/Preferences/net.sourceforge.skim-app.skim.plist $DOTFILES/Skim/settings.plist
```

To use:

```bash
cp $DOTFILES/Skim/settings.plist $HOME/Library/Preferences/net.sourceforge.skim-app.skim.plist
```

### Terminal.app

Use the in-software setting:

*Preferences > Profiles > Import …*

### VSCodium

```bash
ln -s $DOTFILES/VSCodium/settings.json "$HOME/Library/Application Support/VSCodium/User/settings.json"
```

### Zsh

```bash
ln -s $DOTFILES/Zsh/zshrc $HOME/.zshrc
```