#!/bin/bash

PACKAGES_CONFIG_PATH="$HOME/.config/pkg-install-packages";

DUMP_PATH="$PACKAGES_CONFIG_PATH/dump";
PACKAGE_LIST_PATH="$PACKAGES_CONFIG_PATH/macros";
SHELL="bash";

setup() {
  mkdir -p "$DUMP_PATH";
  mkdir -p "$PACKAGE_LIST_PATH";
}

get-macro-path() { echo "$PACKAGE_LIST_PATH/$1"; }

guard() { if [[ -z "$1" ]]; then echo "$2"; exit 1; fi; }
guard-package-name() { guard "$1" "Invalid package name"; }

record() {
  guard-package-name "$1";
  local pkgPath=$(get-macro-path "$1");

  [[ -f "$pkgPath" ]] && guard "" "Macro: '$1' already exists. To delete it, run 'macros delete $1'";

  local currentDir=$(pwd);
  cd "$DUMP_PATH";
  HISTFILE="$pkgPath" CUSTOM_PROMPT=">> " $SHELL;
  cd "$currentDir";
}

delete() {
  guard-package-name "$1";
  local pkgPath=$(get-macro-path "$1");
  rm "$pkgPath";
}

run() {
  guard-package-name "$1";
  local pkgPath=$(get-macro-path "$1");

  [[ ! -f "$pkgPath" ]] && guard "" "Macro '$1' does not exist";

  cat $pkgPath | sed 's/^[0-9: ]\+;//g' | sed '/^(macros )?exit$/d';
  # TODO: Execute the stream of commands (| $SHELL -)
}

run-all() { ls -1 | xargs run; }


setup;

case "$1" in
  start) record "$2" ;;
  run) run "$2" ;;
  all) run-all ;;
  delete) delete "$2" ;;
  stop) exit ;;
  help) echo "Docs not implemented" ;;
esac

