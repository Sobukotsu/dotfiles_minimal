# ~/.zprofile
#
# zsh login shell. Wires up Homebrew only if it's actually installed
# (Apple Silicon, Intel Mac, or Linuxbrew paths); does nothing extra on a
# stock system that doesn't have it.

for brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [ -x "$brew" ]; then
    eval "$("$brew" shellenv)"
    break
  fi
done
