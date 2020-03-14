#!/usr/bin/env bash

MACROS_PATH="$HOME/.config/shell-macros";

source "$MACROS_PATH/default_config.sh";
source "$MACROS_PATH/config.sh";

HELP_TEXT="Usage: macros [command] <args>

Commands:
  start <macro name>    - Creates a new macro recording session
  run <macro name>      - Run a recorded macro
  ls                    - List all available macros
  delete <macro name>   - Delete a macro
  help                  - This dialog
";

get-macro-path() { echo "$MACROS_LIST_PATH/$1"; }

guard() { if [[ -z "$2" ]]; then echo "$1"; exit 1; fi; }

guard-macro-name() {
  guard "Invalid macro name" "$1";
}

guard-macro-not-exists() {
  [[ ! -f "$(get-macro-path "$1")" ]] && \
    guard "Macro '$1' does not exist";
}
guard-macro-already-exists() {
  [[ -f "$(get-macro-path "$1")" ]] && \
    guard "Macro '$1' already exists. To delete it, run 'macros delete $1'";
}

strip_history_timestamp() { sed 's/^\:\s\+[0-9: ]\+;//g'; }


# Start recording a macro
record() {
  guard-macro-name "$1";
  guard-macro-already-exists "$1";
  local macro_path=$(get-macro-path "$1");

  # Start new shell
  HISTFILE="$macro_path" CUSTOM_PROMPT=">> " $SHELL;

  # Remove history timestamps if exists
  contents=$(cat "$macro_path" | strip_history_timestamp);
  echo -e "$contents" > $macro_path;
}

# Delete existing macro
delete() {
  guard-macro-name "$1";
  guard-macro-not-exists "$1";
  local macro_path=$(get-macro-path "$1");

  # Delete session file
  rm "$macro_path";
}

# Execute a macro
run() {
  guard-macro-name "$1";
  guard-macro-not-exists "$1";
  local macro_path=$(get-macro-path "$1");

  # Read and execute each line
  cat $macro_path | $SHELL -;
}

# List all macros
list() { ls -1 $MACROS_LIST_PATH; }

case "$1" in
  start)   record "$2" ;;
  run)     run "$2" ;;
  ls)      list ;;
  delete)  delete "$2" ;;
  *)       echo -e "$HELP_TEXT" ;;
esac

