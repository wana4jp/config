export LANG=ja_JP.UTF-8

autoload -Uz colors
colors

bindkey -e

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

autoload -Uz compinit
compinit

setopt print_eight_bit
setopt interactive_comments
setopt auto_pushd
setopt auto_cd
setopt share_history
setopt auto_menu

PROMPT="%F{yellow} %~ %F{magenta}%# "


# aliases
case ${OSTYPE} in
	darwin*)
		export CLICOLOR=1
		alias ls='ls -a -l -G -F'
		alias ll="ls"
		;;
	linux*)
		;;
esac

alias up='cd ..'
alias upup='cd ../..'
alias upupup='cd ../../../'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

alias vi='vim'
alias v='vi'
alias g='git'

alias gap='git add -p'
alias gb='git branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias ggrep='git grep -i -I'
alias gl='git log'
alias glo='git log --oneline'
alias gpl='git pull'
alias gst='git status'

# vim:set ft=zsh:
