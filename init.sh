#!/bin/sh
MAKE_LINK_LIST=".vim .vimrc .gvimrc .shrc .bashrc .zshrc .gitconfig"
cd $(dirname $0)
for dotfile in $MAKE_LINK_LIST
do
	ln -Fis "$PWD/dotfiles/$dotfile" $HOME
done

source ~/.bashrc

if [ ! -d ~/vimswap ]; then
	mkdir ~/vimswap
fi
