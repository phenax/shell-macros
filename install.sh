#!/usr/bin/env bash

SHELL_MACROS_PATH=$HOME/.config/shell-macros;

clone() {
  git clone https://github.com/phenax/shell-macros.git $SHELL_MACROS_PATH;
}

if [[ -f "$SHELL_MACROS_PATH" ]]; then
  echo "You already have shell-macros installed. Upgrading to latest release";

  echo "Backing up old config"
  TMP_SM_PATH="${SHELL_MACROS_PATH}_backup";
  mv $SHELL_MACROS_PATH $TMP_SM_PATH;

  echo "Upgrading...";
  clone;

  echo "Restoring config";
  cp -rf "$TMP_SM_PATH/dump" "$SHELL_MACROS_PATH/dump";
  cp -rf "$TMP_SM_PATH/macros" "$SHELL_MACROS_PATH/macros";
  cp -rf "$TMP_SM_PATH/config.sh" "$SHELL_MACROS_PATH/config.sh";
else
  echo "Installing...";
  clone;
fi;

cd $SHELL_MACROS_PATH;

rm -rf .git;

mkdir -p $SHELL_MACROS_PATH/dump;
mkdir -p $SHELL_MACROS_PATH/macros;

