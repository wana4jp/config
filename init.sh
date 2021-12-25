#!/bin/sh

for dotfile in `ls -A dotfiles/`
do
   ln -Fis "$PWD/dotfiles/$dotfile" "$HOME"
done

# Neovim
# ln -Fis ~/config/dotfiles/init.vimrc "$HOME/.config/nvim/init.vimrc"

if [ ! -d ~/vimswap ]; then
    mkdir ~/vimswap
fi

if [ ! -f ~/.bashrc.local ]; then
    touch ~/.bashrc.local
fi
if [ ! -f ~/.zshrc.local ]; then
    touch ~/.zshrc.local
fi

if [ ! -d ~/.ssh ]; then
    ln -Fis ~/Dropbox/2_security/_ssh/ ~/.ssh
    chmod 600 ~/.ssh/keys/github
fi

# copy fook scripts when create new git repository
git config --global init.templatedir ~/.git_template