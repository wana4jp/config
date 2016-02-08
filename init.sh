#!/bin/sh

MAKE_LINK_LIST=".bashrc .bash_profile .tmux.conf .zshrc .gitconfig .vimrc .gvimrc .vim .ctags .ideavimrc"

cd $(dirname $0)
for dotfile in $MAKE_LINK_LIST
do
	ln -Fis "$PWD/dotfiles/$dotfile" $HOME
done

source ~/.bashrc
if [ ! -d ~/vimswap ]; then
    mkdir ~/vimswap
fi
