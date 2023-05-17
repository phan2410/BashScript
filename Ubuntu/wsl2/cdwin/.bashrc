# load my utils
# cdwin
CDWIN_ENV_FILE="$HOME/.cdwin.env"
[ -f "$CDWIN_ENV_FILE" ] && { set -a; source "$CDWIN_ENV_FILE"; set +a; }
alias cdwin='source "$HOME/.utils/cdwin"'
