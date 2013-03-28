#!/bin/sh
MAKE_LINK_LIST=".vimrc .vim"
cd $(dirname $0)
for dotfile in $MAKE_LINK_LIST
do
	ln -Fis "$PWD/$dotfile" $HOME
done
