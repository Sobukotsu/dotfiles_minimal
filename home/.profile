# ~/.profile
#
# POSIX login-shell setup. Sourced by `sh`/dash-style login shells, and by
# ~/.bash_profile below. Uses only POSIX builtins — no third-party tools,
# no package manager, nothing that isn't already on a stock Linux/macOS box.

[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"
export PATH

if command -v vim >/dev/null 2>&1; then
  EDITOR=vim
else
  EDITOR=vi
fi
export EDITOR
export LANG="${LANG:-en_US.UTF-8}"
