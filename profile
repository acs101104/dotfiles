#!/bin/bash

export HISTCONTROL=ignoreboth:erasedups

alias ls='ls -al'
alias mkdir='mkdir -p'
alias rm='rm -r'
alias vi='vim'
alias ps="ps aux"
alias du='du -sh'
alias ..='cd ..'

if command -v /opt/homebrew/bin/brew > /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ $(uname -s) == "Darwin" ]; then
    export CLICOLOR=1
    # export LSCOLORS=GxfxdxDxCxegedhbadaced
    export GREP_OPTIONS='--color=always'
    export GREP_COLOR='1;32;40'
    export BASH_SILENCE_DEPRECATION_WARNING=1
fi

git_info() {
	git rev-parse --is-inside-work-tree &>/dev/null || return

	branch=$(git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')
	dirty=$(git diff --quiet --ignore-submodules HEAD &>/dev/null || echo -e "*")

	echo -e " on "$LIGHTRED$branch$dirty$RESET
}

LIGHTRED='\033[1;31m'
BROWN='\033[1;33m'
GREEN='\033[1;32m'
RESET='\033[0m'

PS1="$GREEN\h$RESET $BROWN\w$RESET\$(git_info)\n\$ "
