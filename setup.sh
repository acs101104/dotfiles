#!/usr/bin/env bash

set -eux

# Swithc shell to bash at first
chsh -s /bin/bash

DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

if ! command -v brew > /dev/null; then
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# zule8 has been removed
# Need to download manually from offical website
apps=(
  divvy
  dash
  notion
  # fliqlo
  google-chrome
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
