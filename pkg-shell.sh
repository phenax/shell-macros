#!/bin/bash

PACKAGES_CONFIG_PATH="$HOME/.config/pkg-install-packages";

DUMP_PATH="$PACKAGES_CONFIG_PATH/dump";
PACKAGE_LIST_PATH="$PACKAGES_CONFIG_PATH/sessions";

mkdir -p "$DUMP_PATH";
mkdir -p "$PACKAGE_LIST_PATH";

get-package-session() { echo "$PACKAGE_LIST_PATH/$1"; }

start-session() {
  local pkgPath=$(get-package-session "$1");
  if [[ -f "$pkgPath" ]]; then
    echo "Package: '$1' already exists. To delete it, run 'pkg-shell delete $1'";
  fi

  local currentDir=$(pwd);
  cd "$DUMP_PATH";
  HISTFILE="$pkgPath" CUSTOM_PROMPT="$(pwd) >> " zsh;
  cd "$currentDir";
}

replicate-session() {
  local pkgPath=$(get-package-session "$1");
  cat $pkgPath | sed 's/^[0-9: ]\+;//g' | sed '/^exit$/d';
}

delete-session() {
  local pkgPath=$(get-package-session "$1");
  rm "$pkgPath";
}

replicate-all() {
  ls -1 | xargs replicate-session;
}

case "$1" in
  start) start-session "$2" ;;
  install) replicate-session "$2" ;;
  delete) delete-session "$2" ;;
  all) replicate-all ;;
  exit) exit ;;
esac

