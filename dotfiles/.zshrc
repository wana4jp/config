# global definitions
if [ -f ~/.shrc ]; then
  source ~/.shrc
fi


# settings
autoload -Uz compinit
bindkey -e
export LANG=ja_JP.UTF-8
setopt auto_pushd
setopt interactive_comments
setopt print_eight_bit
setopt pushd_ignore_dups
compinit

# params
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
