export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:$HOME/bin:$PATH
export EDITOR="/usr/local/bin/vim"

# 色の設定を可能にする
autoload -Uz colors
colors

# emacsのバインド
bindkey -e

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

# プロンプト
PROMPT="%F{yellow} %~ %F{magenta}%# "

#############################################
# 補完
# 補完を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'

function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg


########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias ll='ls -l'

alias mkdir='mkdir -p'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
alias up='cd ..'
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
alias gl='git log --stat'
alias glo='git log --oneline'
alias gpl='git pull'
alias gst='git status'

########################################
# OS 別の設定
case ${OSTYPE} in
	darwin*)
		#Mac用の設定
		export CLICOLOR=1
		alias ls='ls -G -F'
		;;
	linux*)
		#Linux用の設定
		alias ls='ls -F --color=auto'
		;;
esac

########################################
# foreground に戻るキーバインド
fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
	BUFFER="fg"
	zle accept-line
else
	zle push-input
	zle clear-screen
	fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

########################################
# fasd
eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-wcomp)"

# vim:set ft=zsh:
export PATH=$(brew --prefix)/bin:$PATH

set -g default-terminal "xterm"
