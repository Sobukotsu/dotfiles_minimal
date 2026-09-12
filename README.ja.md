# dotfiles-minimal

[English](README.md) | [日本語](README.ja.md)

OSをインストールした直後の、まっさらなLinux/mac環境のための最小構成dotfilesです。Homebrewもパッケージマネージャもエディタのプラグインも、何も入れていない状態で動くことを前提にしています。使っているのはOS標準で最初から入っているものだけ — POSIX `sh`、`bash`、`zsh`、`vi`/`vim` です。プラグインマネージャも外部プロンプトツールも、事前に何かをインストールする必要は一切ありません。

これはより機能豊富な個人用dotfilesリポジトリ（`~/dotfiles`）の姉妹版です。あちらはstarship・LazyVim・tmux・Alacritty・Homebrewを前提にしていますが、こちらはOS自体以外何も要らないサブセットだけを切り出したもので、まっさらなマシンやコンテナ、VMを何もインストールしていない状態からブートストラップするためのものです。

## 構成

- `home/` — 全OS共通のdotfiles。`$HOME`からの相対パスをそのまま再現します
  （例: `home/.zshrc` -> `~/.zshrc`）
- `home.Darwin/`, `home.Linux/` — OS固有のdotfiles（任意、現時点では未使用）。
  `home/`の後に適用され、`uname -s`の出力で選択されます
- `install.sh` — `home/` と `home.$(uname -s)/` の中身を `$HOME` にシンボリックリンクします

## 新しいマシンでのセットアップ

```sh
git clone <このリポジトリのURL> ~/dotfiles-minimal
cd ~/dotfiles-minimal
./install.sh
```

`install.sh` は以下を行います。

1. `home/` 配下の各ファイルについて、`$HOME`内の対応するパスにシンボリックリンクを作成
2. `home.$(uname -s)/`（例: `home.Darwin/`）が存在すれば同様に適用
3. リンク先に実体のファイルやシンボリックリンクが既に存在する場合は、削除せず
   `~/.dotfiles-minimal_backup/<timestamp>/` に退避してからリンクを作成
4. 既に正しくリンクされているファイルはスキップ（再実行しても安全）

## 管理しているファイルと、まっさらな環境でも安全な理由

| ファイル | 役割 | まっさらな環境での安全性 |
| --- | --- | --- |
| `.profile` | POSIXログインシェルのPATH/EDITOR設定 | POSIX組み込み機能のみ使用 |
| `.bash_profile` | ログインbashで `.profile` + `.bashrc` を読み込む | 依存なし |
| `.bashrc` | 対話的bash: エイリアス、履歴、プロンプト | `uname -s`でGNU/BSDの`ls`を判別 — Linuxなら`--color=auto`、macOSなら`-G` |
| `.zprofile` | zshログインシェル | Homebrewが実際にインストール済み（既知の3パスをチェック）の場合のみ設定。無ければ何もしない |
| `.zshrc` | 対話的zsh: 補完、履歴、エイリアス、プロンプト | zsh組み込みの`colors`/`PROMPT`のみ使用 — starshipなど外部プロンプトツール不要 |
| `.vimrc` | エディタの基本設定 | 組み込みオプションと組み込みの`default`カラースキームのみ使用。`mouse`/`clipboard`は`has()`でガードし、機能を持たない簡易版vimでもエラーにならない |

あえて含めていないもの（まっさらな環境には存在しない前提のため）: Homebrewの
パッケージリスト（`Brewfile`）、Neovim/LazyVim設定、tmux設定、Alacritty設定、
`claude`やtmux連携のヘルパー関数。これらが依存するツールを実際にインストール
した後で、より機能豊富な `~/dotfiles` リポジトリから追加してください。

## 新しいdotfileの追加

`$HOME`からの相対パスで `home/` 配下に管理したいファイルを置き、
`./install.sh` を再実行してください。

---

Generated with Claude Code (https://claude.com/claude-code)
