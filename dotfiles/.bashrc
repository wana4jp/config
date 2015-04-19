# global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f ~/.git-completion.sh ]; then
  source ~/.git-completion.sh
fi


# settings
set -o noclobber
export EDITOR=/usr/bin/vim
export HISTFILESIZE=100000
export HISTSIZE=100000
export IGNOREEOF=10


# prompt
prompt_setup() {
  local c_reset='\[\e[0m\]'
  local c_cyan='\[\e[36m\]'
  local c_green='\[\e[32m\]'
  local c_red='\[\e[31m\]'
  local c_yellow='\[\e[33m\]'
  local c_gray='\[\e[37m\]'

  local c_user
  case "$USER" in
    root) c_user="$c_red" ;;
  *) c_user="$c_green" ;;
esac

local c_host
if [ -n "$SSH_CONNECTION" ]; then
  c_host="$c_cyan"
else
  c_host="$c_green"
fi

local t_host="$c_user\\u$c_reset$c_host@\\h$c_reset"
local t_cwd="$c_yellow\\w$c_reset"

if [ $SHLVL -gt 1 ]; then
  local t_shlvl=" $c_gray($SHLVL)$c_reset"
else
  local t_shlvl=''
fi

PS1=" $t_host $t_cwd$t_shlvl "
}
prompt_setup
unset -f prompt_setup


# functions
pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
  echo -n "DIRSTACK: "
  dirs
}

popd()
{
  builtin popd > /dev/null
  echo -n "DIRSTACK: "
  dirs
}


# aliases
case "${OSTYPE}" in
  darwin*)
    alias ls="ls -laG"
    ;;
  linux*)
    alias ls='ls -la --color'
    ;;
esac

alias cd="pushd > /dev/null"
alias back="popd"
alias up='cd ..'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mvi='/Applications/MacVim.app/Contents/MacOS/mvim'

#alias vi='mvi'
alias v='vi'
alias g='git'
alias c='cd'
alias ll='ls'
alias l='ls'

alias gap='git add -p'
alias gb='git branch'
alias gd='git diff'
alias gdc='git diff --cached'
alias ggrep='git grep -i -I'
alias gl='git log'
alias glo='git log --oneline'
alias gpl='git pull'
alias gst='git status'

allgrep() { find ./ -name "*" -exec grep $1 "{}" \;; }
phpgrep() { find ./ -name "*.php" -exec grep $1 "{}" \;; }


# local settings
if [ -f ~/.bashrc.local ]; then
  source ~/.bashrc.local
fi
