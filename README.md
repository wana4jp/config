Set Up
-------

```
# dotfiles
./init.sh

# apps
brew install ag
brew install ctags
brew install fasd
brew install shellcheck
brew install s3cmd
brew install tmux
brew install vim --with-lua # lua is for 'neocomplete'

# vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/config/dotfiles/.vim/plugins
rm installer.sh

# symlink for GoogleIME
ln -s ~/Dropbox/JapaneseInput /Users/wanashi/Library/Application\ Support/Google

# symlink for TODO text 

ln -s ~/Dropbox/tasks/ tasks
```
