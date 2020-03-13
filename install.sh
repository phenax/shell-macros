#!/usr/bin/env bash

SHELL_MACROS_PATH=$HOME/.config/shell-macros;

git clone https://github.com/phenax/shell-macros.git $SHELL_MACROS_PATH;

cd $SHELL_MACROS_PATH;

rm -rf .git;

mkdir -p $SHELL_MACROS_PATH/dump;
mkdir -p $SHELL_MACROS_PATH/macros;

