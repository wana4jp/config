Set Up
-------

# common

```shell
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

- [Windows](env/Windows/README.md)
- [macOS](env/macOS/README.md)
