# ~/.bashrc
#
# Interactive bash only. No third-party tools required — just bash and
# coreutils that ship with the OS.

case $- in
  *i*) ;;
  *) return ;;
esac

# GNU coreutils `ls` (stock on Linux) understands --color=auto; BSD `ls`
# (stock on macOS) does not and needs -G / CLICOLOR instead.
case "$(uname -s)" in
  Darwin|*BSD)
    export CLICOLOR=1
    alias ls='ls -G'
    ;;
  *)
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    ;;
esac

alias ll='ls -lh'
alias la='ls -lhA'

HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend 2>/dev/null
shopt -s checkwinsize 2>/dev/null

# Colored prompt using plain ANSI escapes — no starship/powerline required.
PS1='\[\e[32m\]\u@\h\[\e[0m\] \[\e[34m\]\w\[\e[0m\] \$ '
