#!/bin/zsh 

DOT_FILES=(.zsh .zshrc .starship .gitconfig .gitignore_global)
DOT_PATH=$HOME/dotfiles

for file in ${DOT_FILES[@]}
do
  ln -svf $DOT_PATH/$file $HOME/$file
done