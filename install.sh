#!/bin/sh

DOT_FILES=(
  .zshrc
  .gitconfig
  .gitignore_global
  .starship.toml
  .hammerspoon
)
DOT_PATH=$HOME/dotfiles

for file in ${DOT_FILES[@]}; do
  ln -svf $DOT_PATH/$file $HOME/$file
done