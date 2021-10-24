#!/bin/sh
ln -Fis ~/config/os/macOS/karabiner/my_conf.json ~/.config/karabiner/assets/complex_modifications
ln -Fis ~/config/os/macOS/.Brewfile ~/.Brewfile
ln -Fis ~/config/os/macOS/.gvimrc ~/.gvimrc


VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

rm "$VSCODE_SETTING_DIR/settings.json"
ln -Fis ~/config/settings.json "${VSCODE_SETTING_DIR}/settings.json"

rm "$VSCODE_SETTING_DIR/keybindings.json"
ln -Fis ~/config/keybindings.json "${VSCODE_SETTING_DIR}/keybindings.json"

cat ~/config/vscode_extensions | while read line
do
 code --install-extension $line
done

code --list-extensions > ~/config/vscode_extensions
