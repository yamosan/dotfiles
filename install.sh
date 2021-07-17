#!/bin/zsh 

DOT_FILES=(.zsh .zshrc .starship .gitconfig .gitignore_global .hammerspoon)
DOT_PATH=$HOME/dotfiles

for file in ${DOT_FILES[@]}
do
  ln -nsvf $DOT_PATH/$file $HOME/$file
done