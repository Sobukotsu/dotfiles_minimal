# dotfiles-minimal

[English](README.md) | [日本語](README.ja.md)

A minimal-environment dotfiles set for a stock Linux or macOS box, right
after install — before a package manager or any editor plugin has been set
up. Every file here works with only what the OS ships by default: POSIX
`sh`, `bash`, `zsh`, and `vi`/`vim`. No plugin manager, no external prompt
tool, no third-party tool references at all, no packages to install first.

Useful for bootstrapping a fresh machine, a container, or a VM before
anything else has been installed — a sane shell and editor baseline that
works immediately, with nothing to fetch and nothing that can fail to
resolve.

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
| `.zshrc` | Interactive zsh: completion, history, aliases, prompt | Uses zsh's own `colors`/`PROMPT` — no starship or other external prompt tool |
| `.vimrc` | Editor defaults | Builtin options + the builtin `default` colorscheme only; `mouse`/`clipboard` are feature-guarded with `has()` so it doesn't error on a stripped-down vim build |

Deliberately **not** included, since none of it is present on a stock
system: a package manager's manifest (e.g. a Brewfile), editor plugin
configs, a terminal multiplexer config, a GUI terminal emulator config, or
any helper that depends on a tool this repo doesn't already assume. Once
you've installed something beyond the OS defaults, manage its config in a
separate, dedicated dotfiles setup.

## Adding a new dotfile

Place the file you want to manage under `home/`, using its path relative
to `$HOME`, then re-run `./install.sh`.

---

Generated with Claude Code (https://claude.com/claude-code)
