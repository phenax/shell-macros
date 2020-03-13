# Shell Macros
Write command line macros in bash and zsh

## Prerequisites
You need the `git` and `curl` to use the macros install script
```bash
sudo apt install git curl
```


## Installation

To install this, just run this script
```bash
curl https://raw.githubusercontent.com/phenax/shell-macros/master/install.sh | bash -
```


## Usage

Run the help command to see the list of available commands
```bash
macros help
```

#### Commands
```
Commands:
  start <macro name>    - Creates a new macro recording session
  stop                  - Stop recording (exit)
  run <macro name>      - Run a recorded macro
  ls                    - List all available macros
  delete <macro name>   - Delete a macro
  help                  - This dialog
```

#### For bash
Add this to the bottom of your `~/.bashrc`
```bash
source ~/.shell-macros/adapters/bash;
```

#### For zsh
Add this to the bottom of your `~/.zshrc`
```bash
source ~/.shell-macros/adapters/zsh;
```
