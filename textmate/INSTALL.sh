#!/bin/zsh

# Linking to 'Application Support' allows me to changes the settings via Preferences.
ln -fs $DOTFILES/textmate/Global.tmProperties "$HOME/Library/Application Support/TextMate/Global.tmProperties"

# I want to keep my bundles locked.
ln -fs $DOTFILES/textmate/bundles "$HOME/Library/Application Support/TextMate/Managed/Bundles"

# Change the icon (because I need things to be pretty).
sudo cp $DOTFILES/textmate/TextMate.icns /Applications/TextMate.app/Contents/Resources/TextMate.icns