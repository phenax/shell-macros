#!/usr/bin/env bash

MACROS_PATH="$HOME/.config/shell-macros";

source "$MACROS_PATH/default_config.sh";
source "$MACROS_PATH/config.sh";

get-macro-path() { echo "$MACROS_LIST_PATH/$1"; }

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


case "$1" in
  start) record "$2" ;;
  run) run "$2" ;;
  delete) delete "$2" ;;
  stop) exit ;;
  help) echo "Docs not implemented" ;;
esac

