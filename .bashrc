export EDITOR=/usr/bin/vim

# .bashrc
export HISTSIZE=100000
export HISTFILESIZE=100000

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source git-completion
if [ -f $HOME/.git-completion.sh ]; then
	source $HOME/.git-completion.sh
fi

#export PS1='\[\033[01;32m\]\u@\H\[\033[01;34m\] \w \$\[\033[00m\] $(__git_ps1 " (%s)") '
export  PS1='\e[0;31m\h:\W \u\$ \e[0m'

# 事故防止 http://blog.livedoor.jp/dankogai/archives/51863725.html
alias rm='rm -i'
set -o noclobber

export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
alias gvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@" '
alias gvi='gvim --remote-tab-silent'

# Ailias
case "${OSTYPE}" in
darwin*)
  alias ls="ls -G"
  alias ll="ls -lG"
  alias la="ls -laG"
  ;;
linux*)
  alias ls='ls --color'
  alias ll='ls -la --color'
  alias la='ls -la --color'
  ;;
esac

alias ..='cd ..'
alias vi='vim'

# Git Ailias
alias   gap='git add -p'

alias    gb='git branch'
alias   gbr='git branch -r'

alias    gf='git fetch'

alias    gd='git diff'
alias   gdc='git diff --cached'

alias    gl='git log'
alias   glo='git log --oneline'

alias  gcom='git checkout master'
alias   gpl='git pull'

alias   gst='git status'

alias ggrep='git grep -i -I'
