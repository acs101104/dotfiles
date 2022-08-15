#!/usr/bin/env bash

set -e

DIR="$( cd "$(dirname "${BASH_SOURCE[0]}")" && pwd )"

# Change default shell to bash
if [ "$SHELL" != "/bin/bash" ]; then
    chsh -s /bin/bash
fi

# Installing homebrew
if ! command -v brew > /dev/null; then
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

# Installing desktop applications
apps=(
    appcleaner
    google-chrome
    visual-studio-code
)
brew install --cask --appdir="/Users/$USER/Applications" ${apps[@]}

# Copy dot files
dotfiles=(
    profile
    gitconfig
    vimrc
)
for file in ${dotfiles[@]}; do
  cp $DIR/$file ~/.$file
done
