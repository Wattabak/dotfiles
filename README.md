# dotfiles

Dotfiles managed with a bare git repo. Configs tracked directly in `$HOME` without symlinks.

About dotfile management:
Inspiration from @DerekTaylor's (Dotfiles repo)[https://gitlab.com/dwt1/dotfiles],

Article on managing dotfiles: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/

---

## Structure

```
~/.dotfiles/          # bare git repo
~/.gitconfig          # git config (tracked) — portable settings only
~/.gitconfig.local    # git config (NOT tracked) — user, email, credentials
~/.tmux.conf          # tmux config (tracked)
~/.zshrc              # shell config (tracked)
~/.dotfile-profile    # machine profile — NOT tracked, set per machine
~/.tmux/resurrect/
  personal/           # tmux sessions for personal machine
  work/               # tmux sessions for work machine
```

### Key files

| File | Tracked | Purpose |
|---|---|---|
| `~/.gitconfig` | yes | Portable git settings — editor, difftool, aliases |
| `~/.gitconfig.local` | no | Machine-specific — user name, email, credentials |
| `~/.dotfile-profile` | no | Profile name for this machine (`personal` or `work`) |
| `~/.zshrc` | yes | Sources the profile, exports `$DOTFILE_PROFILE` |
| `~/.tmux.conf` | yes | Uses `$DOTFILE_PROFILE` to pick the resurrect session dir |

---

## Multi-machine / profile setup

Each machine has a `~/.dotfile-profile` file containing one word — the profile name. This file is **not tracked** in the dotfiles repo (it's machine-specific).

**`~/.zshrc`** reads it on shell start:
```zsh
export DOTFILE_PROFILE=$(cat ~/.dotfile-profile 2>/dev/null || echo "personal")
```

**`~/.tmux.conf`** uses it to point tmux-resurrect at the right session directory:
```
%if "#{==:#{E:DOTFILE_PROFILE},work}"
set -g @resurrect-dir '~/.tmux/resurrect/work'
%else
set -g @resurrect-dir '~/.tmux/resurrect/personal'
%endif
```

tmux-continuum auto-saves sessions every 15 minutes into the active profile dir and restores them on tmux start.

---

## Setting up a new machine

```bash
# 1. Clone the bare repo
git clone --bare <repo-url> ~/.dotfiles

# 2. Check out tracked files
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout

# 3. Set the machine profile
echo "personal" > ~/.dotfile-profile   # or "work"

# 4. Create ~/.gitconfig.local with credentials for this machine
cat > ~/.gitconfig.local << 'EOF'
[user]
    name = Your Name
    email = you@example.com

[credential "https://github.com"]
    username = your-github-username

[credential]
    helper = /path/to/git-credential-manager
EOF

# 5. Start a new shell — zshrc will create the resurrect dir automatically

# 6. Start tmux — tpm will install plugins on first run, continuum will restore sessions
```

### Seeding the work profile from the committed session file

The dotfiles repo contains a reference work session at `~/.dotfiles/tmux/resurrect/`. On a new work machine, seed it:

```bash
mkdir -p ~/.tmux/resurrect/work
cp ~/.dotfiles/tmux/resurrect/tmux_resurrect_*.txt ~/.tmux/resurrect/work/
# Point 'last' at the file you want to restore
cd ~/.tmux/resurrect/work && ln -sf tmux_resurrect_<timestamp>.txt last
```

---

## dotfiles alias

```zsh
alias dotfiles='/usr/bin/git --git-dir=$DOTFILES --work-tree=$HOME'
```

Use `dotfiles` like a regular git command to track/untrack files:

```bash
dotfiles status
dotfiles add ~/.tmux.conf
dotfiles commit -m "update tmux config"
dotfiles push
```

---

## Git aliases

| Alias | Command | Description |
|---|---|---|
| `git dv` | `DiffviewOpen` | Open diff in nvim Diffview (accepts optional ref, e.g. `git dv HEAD~3`) |

Works with `dotfiles` too: `dotfiles dv c16cd9b`

---

## Neovim keybindings

### Diffview (git)

| Key | Action |
|---|---|
| `<leader>gd` | Open diffview (diff against index) |
| `<leader>gD` | Open diffview against a branch (prompts for name, tab-completes) |
| `<leader>gq` | Close diffview |
| `<leader>gs` | Toggle scroll sync between diff panes (only in diffview) |
| `<leader>gh` | File git history (current file) |
| `<leader>gH` | Branch git log (all commits with diffs) |
| `<leader>gr` | Stage all + continue rebase + close diffview |

#### Conflict resolution commands

| Command | Action |
|---|---|
| `:ConflictAcceptTheirs` | Accept theirs for all conflicts in current file |
| `:ConflictAcceptAllTheirs` | Accept theirs for all conflicts in all files |
| `do` | Pull hunk from other pane into current (built-in vim) |
| `dp` | Push hunk from current pane to other (built-in vim) |

### Telescope

| Key | Action |
|---|---|
| `<leader>fgb` | Find files by name |
| `<leader>fg` | Live grep (search file contents) |
| `<leader>fw` | Search workspace symbols (classes, functions, etc.) |
| `<leader>ft` | Git files |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |

### LSP (built-in Neovim 0.11)

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `K` | Hover docs |
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Find references |
| `gri` | Go to implementation |

### General

| Key | Action |
|---|---|
| `-` | Open parent directory (Oil) |
