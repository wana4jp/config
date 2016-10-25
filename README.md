Set Up
-------

# common

```
# dotfiles
./init.sh

# vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/config/dotfiles/.vim/plugins
rm installer.sh

# symlink for TODO text 

ln -s ~/Dropbox/tasks/ tasks
```

# particular operating system

[Windows](config/env/Windows/README.md)
[macOS](config/env/macOS/README.md)
