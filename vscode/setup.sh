#!/bin/zsh 

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

ln -svf "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"

install extention
cat extensions | while read line
do
 code --install-extension $line
done

# code --list-extensions > extensions