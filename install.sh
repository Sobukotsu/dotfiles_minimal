#!/bin/sh
# Symlinks files under home/ (and home.$(uname -s)/ if present) into $HOME.
# Existing real files are moved into a timestamped backup dir, never deleted.
set -eu
# pipefail is a bash/zsh/ksh extension (not POSIX). Enable it only when the
# running shell supports it, so a strict POSIX sh (e.g. dash) doesn't abort here.
if (set -o pipefail) 2>/dev/null; then
  set -o pipefail
fi

# $0 is POSIX; BASH_SOURCE is bash-only and unset under `sh`/dash.
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-minimal_backup/$(date +%Y%m%d%H%M%S)"
OS="$(uname -s)"

link_tree() {
  src_root="$1"
  [ -d "$src_root" ] || return 0

  find "$src_root" -type f | while IFS= read -r src; do
    rel="${src#"$src_root"/}"
    dest="$HOME/$rel"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      echo "skip (already linked): $rel"
      continue
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
      mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
      mv "$dest" "$BACKUP_DIR/$rel"
      echo "backup: $rel -> ${BACKUP_DIR#"$HOME"/}/$rel"
    fi

    ln -s "$src" "$dest"
    echo "linked: $rel"
  done
}

link_tree "$DOTFILES_DIR/home"
link_tree "$DOTFILES_DIR/home.$OS"

echo
echo "Done. Backups (if any): $BACKUP_DIR"
