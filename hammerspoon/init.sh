#!/bin/sh

SCRIPT_DIR=$(cd $(dirname $0) && pwd)

ln -svf "$SCRIPT_DIR/.hammerspoon" "${HOME}/.hammerspoon"