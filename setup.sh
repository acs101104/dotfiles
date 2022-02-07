#!/usr/bin/env bash

set -eux

# Switch default shell to bash
if [ "$SHELL" != "/bin/bash" ]; then
    chsh -s /bin/bash
fi

DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

if ! command -v brew > /dev/null; then
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# zulu8 need to download from offical website manually
apps=(
  divvy
  notion
  # appcleaner
  intellij-idea
)

# --appdir means that only install those apps for current user
brew install --cask --appdir="/Users/$USER/Applications" ${apps[@]}

dotfiles=(
  profile
  gitconfig
  vimrc
)

for file in ${dotfiles[@]}; do
  cp $DIR/$file ~/.$file
done
