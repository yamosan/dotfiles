#!/bin/sh

if test ! $(which brew);then
  echo "  Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "  Updating homebrew..."
brew update && brew upgrade

echo "  Installing homebrew packages..."
cd `dirname $0`
brew bundle --file=".Brewfile"

echo "  Finished!"