#!/bin/bash

PACKAGES_CONFIG_PATH="$HOME/.config/pkg-install-packages";

DUMP_PATH="$PACKAGES_CONFIG_PATH/dump";
PACKAGE_LIST_PATH="$PACKAGES_CONFIG_PATH/macros";
SHELL_NAME="bash";

mkdir -p "$DUMP_PATH";
mkdir -p "$PACKAGE_LIST_PATH";

get-macro-path() { echo "$PACKAGE_LIST_PATH/$1"; }

record() {
  local pkgPath=$(get-macro-path "$1");

  if [[ -f "$pkgPath" ]]; then
    echo "Macro: '$1' already exists. To delete it, run 'macros delete $1'";
  fi

  local currentDir=$(pwd);
  cd "$DUMP_PATH";
  HISTFILE="$pkgPath" CUSTOM_PROMPT=">> " $SHELL_NAME;
  cd "$currentDir";
}

delete() {
  local pkgPath=$(get-macro-path "$1");
  rm "$pkgPath";
}

run() {
  local pkgPath=$(get-macro-path "$1");
  cat $pkgPath | sed 's/^[0-9: ]\+;//g' | sed '/^(macros )?exit$/d';
}

run-all() { ls -1 | xargs run; }

case "$1" in
  start) record "$2" ;;
  run) run "$2" ;;
  delete) delete "$2" ;;
  all) run-all ;;
  exit) exit ;;
esac

