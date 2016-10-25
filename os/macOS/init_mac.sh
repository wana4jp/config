#!/bin/sh
MAKE_LINK_LIST=".slate.js"
cd $(dirname $0)
for dotfile in $MAKE_LINK_LIST
do
	ln -Fis "$PWD/$dotfile" $HOME
done

# KeyRemap4MacBook
ln -Fis $PWD/private.xml $HOME/Library/Application\ Support/Karabiner
