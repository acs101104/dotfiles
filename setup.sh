#!/usr/bin/env bash

set -eux

# chsh -s /bin/bash

DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

if ! command -v brew > /dev/null; then
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

apps=(
  zulu8
  divvy
  intellij-idea
  # google-chrome
  # dash
  # fliqlo
  # notion
)

brew install --cask --appdir="/Users/$USER/Applications" ${apps[@]}

dotfiles=(
  profile
  gitconfig
)

for file in ${dotfiles[@]}; do
  cp $DIR/$file ~/.$file
done