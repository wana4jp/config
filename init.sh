#!/bin/sh

MAKE_LINK_LIST=".bashrc .zshrc .gitconfig .vimrc .gvimrc .vim"

cd $(dirname $0)
for dotfile in $MAKE_LINK_LIST
do
	ln -Fis "$PWD/dotfiles/$dotfile" $HOME
done

source ~/.bashrc
if [ ! -d ~/vswap ]; then
    mkdir ~/vswap
fi
