#!/bin/sh

for dotfile in `ls -A dotfiles/`
do
	ln -Fis "$PWD/dotfiles/$dotfile" "$HOME"
done

if [ ! -d ~/vimswap ]; then
    mkdir ~/vimswap
fi

# copy fook scripts when create new git repository
git config --global init.templatedir ~/.git_template
