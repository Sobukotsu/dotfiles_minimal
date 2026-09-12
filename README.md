# dotfiles-minimal

[English](README.md) | [日本語](README.ja.md)

A minimal-environment dotfiles set for a stock Linux or macOS box, right
after install — before Homebrew, a package manager, or any editor plugin
has been set up. Every file here works with only what the OS ships by
default: POSIX `sh`, `bash`, `zsh`, and `vi`/`vim`. No plugin manager, no
external prompt tool, no packages to install first.

This is a companion to a fuller personal dotfiles repo (`~/dotfiles`) that
adds starship, LazyVim, tmux, Alacritty, and Homebrew — this repo is the
subset of that setup that needs nothing beyond the OS itself, for bootstrapping
a fresh machine, a container, or a VM before anything else is installed.

## Layout

- `home/` — dotfiles common to all OSes. Mirrors the relative path under
  `$HOME` (e.g. `home/.zshrc` -> `~/.zshrc`)
- `home.Darwin/`, `home.Linux/` — OS-specific dotfiles (optional, none yet).
  Applied after `home/`, selected by the output of `uname -s`
- `install.sh` — symlinks the contents of `home/` and `home.$(uname -s)/`
  into `$HOME`

## Setting up a new machine

```sh
git clone <this repo's URL> ~/dotfiles-minimal
cd ~/dotfiles-minimal
./install.sh
```

`install.sh` does the following:

1. For each file under `home/`, creates a symlink at the corresponding
   path in `$HOME`
2. Applies `home.$(uname -s)/` (e.g. `home.Darwin/`) the same way, if it
   exists
3. If a real file or symlink already exists at the destination, it is
   moved (not deleted) to `~/.dotfiles-minimal_backup/<timestamp>/` before
   linking
4. Skips files that are already linked correctly (safe to re-run)

## What's managed, and why it's safe on a fresh install

| File | Purpose | Fresh-install safety |
| --- | --- | --- |
| `.profile` | POSIX login shell PATH/EDITOR setup | Pure POSIX builtins |
| `.bash_profile` | Sources `.profile` + `.bashrc` for login bash | No dependency |
| `.bashrc` | Interactive bash: aliases, history, prompt | Detects GNU vs BSD `ls` via `uname -s` — `--color=auto` on Linux, `-G` on macOS |
| `.zprofile` | zsh login shell | Only touches Homebrew if it's already installed (checks 3 known paths); no-op otherwise |
| `.zshrc` | Interactive zsh: completion, history, aliases, prompt | Uses zsh's own `colors`/`PROMPT` — no starship or other external prompt tool |
| `.vimrc` | Editor defaults | Builtin options + the builtin `default` colorscheme only; `mouse`/`clipboard` are feature-guarded with `has()` so it doesn't error on a stripped-down vim build |

Deliberately **not** included, since none of it is present on a stock
system: Homebrew package list (`Brewfile`), Neovim/LazyVim config, tmux
config, Alacritty config, or any `claude`/tmux integration helpers. Add
those from the fuller `~/dotfiles` repo once you've actually installed the
tools they depend on.

## Adding a new dotfile

Place the file you want to manage under `home/`, using its path relative
to `$HOME`, then re-run `./install.sh`.

---

Generated with Claude Code (https://claude.com/claude-code)
