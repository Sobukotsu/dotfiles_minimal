# ~/.bash_profile
#
# Sourced for login bash shells (e.g. macOS Terminal.app tabs, most Linux
# TTY logins). Pulls in the POSIX-common profile, then interactive bash
# settings.

[ -f "$HOME/.profile" ] && . "$HOME/.profile"
[ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"
