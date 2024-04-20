#!/bin/zsh

mkdir -p $HOME/.emacs.d

ln -fs $DOTFILES/emacs/init.el $HOME/.emacs.d/
ln -fs $DOTFILES/emacs/elisp $HOME/emacs

# Change the icon (because I need things to be pretty).
sudo cp $DOTFILES/emacs/Emacs.icns /Applications/MacPorts/Emacs.app/Contents/Resources/Emacs.icns
