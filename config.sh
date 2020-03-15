MACROS_PATH="$HOME/.config/shell-macros";
source "$MACROS_PATH/colors.sh";

export SHELL="bash";

# Return prompt string
get_prompt() { echo -e "\$(${COLOR_LIGHT_GREEN}$1${COLOR_DEFAULT}) >> "; }

