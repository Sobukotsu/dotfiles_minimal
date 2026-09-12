# ~/.zshrc
#
# Minimal zsh config: zsh builtins only. No plugin manager, no
# starship/powerlevel10k, no dependency on this machine having anything
# beyond zsh itself.

autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
setopt histignoredups sharehistory
bindkey -e

# GNU coreutils `ls` (stock on Linux) understands --color=auto; BSD `ls`
# (stock on macOS) does not and needs -G instead.
case "$(uname -s)" in
  Darwin|*BSD) alias ls='ls -G' ;;
  *)           alias ls='ls --color=auto' ;;
esac
alias ll='ls -lh'
alias la='ls -lhA'

[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# Colored prompt using zsh's builtin prompt expansion — no external prompt
# tool required.
autoload -Uz colors && colors
PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '
