# Neovim Cheat Sheet

Print this and keep it next to your keyboard. Everything here works on any dojo machine. When you are lost, press `Esc`.

---

## The Two Modes

| Mode | What letters do | How to get there |
|------|-----------------|------------------|
| Normal | Letters are commands | `Esc` (always) |
| Insert | Letters are text | `i` |

---

## Survival

| Keys | What happens |
|------|--------------|
| `i` | Start typing |
| `Esc` | Stop typing |
| `Space w` | Save |
| `Space q` | Quit |
| `:q!` `Enter` | Quit without saving |
| `u` | Undo |
| `Ctrl+r` | Redo |

---

## Moving

| Keys | Where you go |
|------|--------------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Next word / back a word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `5j` | Down 5 lines (use the relative numbers) |
| `Ctrl+d` / `Ctrl+u` | Half a page down / up |
| `/word` `Enter` | Search, then `n` for next match |

---

## Editing (verb plus noun)

| Keys | What happens |
|------|--------------|
| `ciw` | Change the word under the cursor |
| `ci"` | Change inside the quotes |
| `dw` | Delete to the next word |
| `dd` | Delete the line |
| `yy` | Copy the line |
| `p` | Paste below |
| `.` | Repeat the last change |

---

## Dojo Keys (Space is the leader)

| Keys | What happens |
|------|--------------|
| `Space t` | Run tests on this file |
| `Space ta` | Run all tests |
| `Space tw` | Watch tests on this file |
| `Space e` | File explorer |
| `Space v` / `Space s` | Vertical / horizontal split |
| `Ctrl+h/j/k/l` | Move between splits |
| `Space gs` | Git status |
| `Space gd` | Git diff |
| `Space gl` | Git log |

---

## When You Are Stuck

| Keys | What happens |
|------|--------------|
| `Esc` | Back to normal mode, always safe |
| `:help word` | Read the manual for anything |
| `:q!` `Enter` | Abandon ship, nothing is saved |

The editor cannot be broken by pressing keys. The worst case is quitting without saving and opening the file again.
