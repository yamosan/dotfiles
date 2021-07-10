#!/bin/zsh 

DOT_FILES=(.zshrc .zsh .starship)

for file in ${DOT_FILES}
do
  ln -fs $HOME/dotfiles/$file $HOME/$file
done