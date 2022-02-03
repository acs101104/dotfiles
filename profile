#!/bin/bash

export HISTCONTROL=ignoreboth:erasedups

alias ll='ls -al'
alias vi='vim'
alias ps="ps aux"
alias du='du -sh'

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v kubectl &> /dev/null; then
    alias k='kubectl'
    alias do='--dry-run=client -o yaml'
    alias now='--force --grace-period 0'
    export KUBE_EDITOR="vim"
fi

if [ $(uname -s) == "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS=GxfxdxDxCxegedhbadaced
    export GREP_OPTIONS='--color=always'
    export GREP_COLOR='1;32;40'
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

port() {
    lsof -iTCP:$1 -sTCP:LISTEN
}

LIGHTRED='\033[1;31m'
BROWN='\033[1;33m'
GREEN='\033[1;32m'
RESET='\033[0m'

git_info() {
	git rev-parse --is-inside-work-tree &>/dev/null || return

	branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
	dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null ||  echo -e "*")

	echo -e " on "$LIGHTRED$branch$dirty$RESET
}

PS1="$GREEN\u@\h$RESET $BROWN\w$RESET\$(git_info)\n\$ "
