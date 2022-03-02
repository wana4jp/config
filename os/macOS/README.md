Set Up for macOS
-------

## Disable sound effect

System Preference -> Sound

## Install Dropbox
https://www.dropbox.com/install

## Setup github ssh key

`ln -Fis ~/Dropbox/2_security/_ssh/ ~/.ssh`
`chmod 600 ~/.ssh/keys/github`

## Clone this repository

`git clone git@github.com:wana4jp/config.git`

## Install Homebrew
https://brew.sh/

## Download Terminal Theme (& Restart)
https://draculatheme.com/terminal/

## Create symlink

### Common

`./init.sh`

### For Mac

`./init_mac.sh`

## Log in App Store

## Install applications

`brew bundle`

## Set up applications
### Set up vim

TODO

### Set up iTerm2

import `myconf.itermkeymap`

### Set up VSCode

Log in with my account and sync settings VSCode

### Set up IntelliJ / Android studio

Setting Repository
https://www.jetbrains.com/help/idea/settings-tools-settings-repository.html

URL: https://github.com/wana4jp/IntelliJ

## Setup Programming Languages

https://github.com/asdf-vm/asdf

### Node.js

https://github.com/asdf-vm/asdf-nodejs

### Flutter

https://github.com/oae/asdf-flutter

### Rust

TBD

### Python

https://github.com/danhper/asdf-python

`asdf plugin add python`

`asdf list all python`

`asdf install python 3.10.2`
