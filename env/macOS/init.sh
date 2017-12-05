#!/bin/sh
for file in `ls -A ~/config/env/macOS/karabiner/`
do
  ln -Fis ~/config/env/macOS/karabiner/$file ~/.config/karabiner/assets/complex_modifications/
done
