[ -n "$PS1" ] && source ~/.bash_profile;

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
