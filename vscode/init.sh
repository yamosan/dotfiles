#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0) && pwd)
VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User

ln -svf "$SCRIPT_DIR/settings.json" "${VSCODE_SETTING_DIR}/settings.json"
ln -svf "${SCRIPT_DIR}/snippets" "${VSCODE_SETTING_DIR}/snippets"
