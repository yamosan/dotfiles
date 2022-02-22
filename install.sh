#!/bin/sh

DOT_FILES=(.zshrc .starship .gitconfig .gitignore_global .hammerspoon)
DOT_PATH=$HOME/dotfiles

for file in ${DOT_FILES[@]}; do
  ln -svf $DOT_PATH/$file $HOME/$file
done