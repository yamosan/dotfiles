#!/bin/zsh

source ./zsh/zshenv
source ./zsh/zshrc

symlink() {
  if [ -e "$2" ]; then
    if [ "$(readlink "$2")" = "$1" ]; then
      echo "skipped:  $1"
      return 0
    else
      mv "$2" "$2.backup"
      echo "moved:     $2 to $2.backup"
    fi
  fi
  ln -sf "$1" "$2"
  echo "linked:   $1 -> $2"
}

# Zsh
mkdir -p "$ZDOTDIR"
symlink "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
symlink "$DOTFILES/zsh/zshrc" "$ZDOTDIR/.zshrc"

# Git
mkdir -p "$XDG_CONFIG_HOME/git"
symlink "$DOTFILES/git/config" "$XDG_CONFIG_HOME/git/config"
symlink "$DOTFILES/git/ignore" "$XDG_CONFIG_HOME/git/ignore"

# Starship
mkdir -p "$XDG_CONFIG_HOME/starship"
symlink "$DOTFILES/starship/starship.toml" "$XDG_CONFIG_HOME/starship/starship.toml"

# hammerspoon
mkdir -p "$XDG_CONFIG_HOME/hammerspoon"
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
symlink "$DOTFILES/hammerspoon" "$XDG_CONFIG_HOME/hammerspoon"

# VSCode
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User
symlink "$DOTFILES/vscode/snippets" "$VSCODE_SETTING_DIR/snippets"
symlink "$DOTFILES/vscode/settings.json" "$VSCODE_SETTING_DIR/settings.json"
symlink "$DOTFILES/vscode/keybindings.json" "$VSCODE_SETTING_DIR/keybindings.json"

# Sheldon
mkdir -p "$XDG_CONFIG_HOME/sheldon"
symlink "$DOTFILES/sheldon" "$XDG_CONFIG_HOME/sheldon"

# WezTerm
mkdir -p "$XDG_CONFIG_HOME/wezterm"
symlink "$DOTFILES/wezterm" "$XDG_CONFIG_HOME/wezterm"

exec $SHELL -l
