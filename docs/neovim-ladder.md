# The Neovim Ladder

Open the editor config on your dojo machine and read the third line of the header:

```
Minimal. Intentional. No plugins until you earn them.
```

That line is a promise, and this guide is how you keep it. The config on your machine is the house config. It works, it is fast, and it is not yours. Somebody else chose every line of it.

By the end of your internship you will have written your own Neovim config in Lua, line by line, and you will be able to explain every single line in it. It will live in a git repository that leaves with you when you go. Nobody hands you a workspace at the dojo. You build one.

This is a ladder. You climb it one rung at a time, in order, and you do not skip rungs. Each rung ends with a proof, something you do without looking anything up. If you cannot do the proof, stay on the rung. There is no prize for rushing and no shame in a slow climb. A rung a week is a good rhythm. Some rungs take two weeks. That is fine.

There is one rule that never changes, on every rung, forever:

**Never put a line in your config that you cannot explain.**

Not from a video, not from someone else's dotfiles, not from an AI. If you want a line, you earn it by understanding it first.

---

## The Rungs at a Glance

| Rung | Name | You can now |
|------|------|-------------|
| 0 | Get In, Get Out | Open, edit, save, and quit without fear |
| 1 | Move Without Thinking | Navigate a file without arrow keys or mouse |
| 2 | Learn the Language | Combine verbs and nouns to edit at speed |
| 3 | Read the House Config | Explain what the dojo config actually does |
| 4 | Start Your Own | Run your own config alongside the house one |
| 5 | Your Own Keymaps | Bind keys that match how you work |
| 6 | Teach It Habits | Write autocmds that act for you |
| 7 | Earn Your First Plugin | Justify, install, and configure one plugin |
| 8 | Your Workspace | Work a full kata in an editor that is yours |

---

## Rung 0: Get In, Get Out

Neovim has modes. In **normal mode**, letters are commands. In **insert mode**, letters are text. Every horror story about being trapped in Vim is someone stuck between these two modes without knowing it.

You need exactly five things to survive:

| Keys | What happens |
|------|--------------|
| `i` | Start typing (insert mode) |
| `Esc` | Stop typing (back to normal mode) |
| `Space` then `w` | Save |
| `Space` then `q` | Quit |
| `:q!` then `Enter` | Quit and throw away changes |

The drill: run `nvim practice.txt`, press `i`, type a sentence, press `Esc`, save with `Space w`, quit with `Space q`. Do this ten times. Then do it once more but quit with `:q!` instead and check the file did not change.

When lost, press `Esc`. It always brings you back to normal mode. `Esc` is home.

**The proof:** open a file, add a line, save, and quit. Then open it, make a change you regret, and leave without saving. Both without looking at this page.

---

## Rung 1: Move Without Thinking

In normal mode you move with `h` `j` `k` `l`: left, down, up, right. Your hands never leave the home row. These are the same keys that move you between i3 windows and tmux panes, which is not a coincidence. The whole dojo speaks this dialect.

Look at the line numbers on your screen. The current line shows its real number and every other line shows its distance from you. That is called relative numbering and it exists so you can jump: `5j` means five lines down, `12k` means twelve lines up. You never count lines by pressing a key repeatedly.

| Keys | Where you go |
|------|--------------|
| `h` `j` `k` `l` | One step left, down, up, right |
| `w` / `b` | Next word / back a word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `5j`, `12k` | Jump by the relative line numbers |
| `Ctrl+d` / `Ctrl+u` | Half a page down / up |
| `/word` then `Enter` | Search for a word, `n` for next match |

The drill: open any file from a kata and give yourself targets. Third word of the last line. The word `function` wherever it appears. The closing bracket at the end. Get there in as few keys as you can.

The habit that makes this stick: for one full week, do not touch the arrow keys. It will be annoying for two days. Then it will not be.

**The proof:** open a file of at least fifty lines and reach any word an instructor or pair partner names, in under five seconds, using counts and search rather than holding a key down.

---

## Rung 2: Learn the Language

This is the rung where Vim stops being a weird editor and starts being a language. Editing commands are sentences: a verb, then a noun.

The verbs: `d` delete, `c` change (delete and start typing), `y` yank (copy). The nouns are the motions you learned on Rung 1, plus text objects like `w` (word), `i"` (inside quotes), `ip` (inside paragraph).

| Sentence | What it says |
|----------|--------------|
| `dw` | Delete to the next word |
| `ciw` | Change the word under the cursor |
| `ci"` | Change everything inside the quotes |
| `dd` / `yy` | Delete / copy the whole line |
| `p` | Paste below |
| `u` / `Ctrl+r` | Undo / redo |
| `.` | Repeat the last change |

Once you see the pattern you can say sentences nobody taught you. If `ci"` changes inside quotes, then `di(` deletes inside brackets, and `yap` copies a paragraph. You are not memorising commands any more. You are speaking.

The drill: take a test file from a past kata, copy it to `practice.js`, and wreck it on purpose. Rename every variable with `ciw`. Swap two lines with `dd` and `p`. Change a string with `ci"`. Undo everything with `u` and watch each change unwind.

**The proof:** rename a variable, change a string without touching the quotes, and move a line somewhere else, each in a single sentence, and then repeat one of them with `.` alone.

---

## Rung 3: Read the House Config

You have been living in someone else's house. Time to read the walls.

Open the config:

```bash
nvim ~/.config/nvim/init.lua
```

It is about 150 lines of Lua and you can now read it, because you have felt what most of it does. `vim.opt.relativenumber = true` is why the line numbers count distance. `vim.opt.scrolloff = 8` is why the cursor never touches the top or bottom edge. The keymap block is where `Space w` comes from.

Neovim documents every option it has. Put your cursor in the editor and ask it:

```
:help relativenumber
:help scrolloff
:help clipboard
```

The drill: go through the config one line at a time. For every `vim.opt` line, read its `:help` page, then say out loud, in plain words, what your editor would feel like without it. If you cannot say it, try it: set the option to `false`, restart, feel the difference, put it back.

This is the most important rung on the ladder and the least glamorous. You are learning to question a world someone else configured for you. Every default was a decision. From here on, you make the decisions.

**The proof:** pick any three lines of the house config and explain each in one plain sentence. Then name one line you would change, and why. There is no wrong answer, but "I do not know" fails the proof and "because a video said so" fails it harder.

---

## Rung 4: Start Your Own

Today your own config is born. Not a copy of the house one. Empty.

Neovim can run a completely separate config depending on an environment variable, which means the house config stays untouched for dojo drills and your config grows beside it. Create the folder and the alias:

```bash
mkdir -p ~/.config/nvim-mine
echo "alias mynvim='NVIM_APPNAME=nvim-mine nvim'" >> ~/.bashrc
source ~/.bashrc
```

Now `nvim` opens the house editor and `mynvim` opens yours. Yours is bare: no colours, no line numbers, absolute defaults. Feel how raw it is. That rawness is your starting point, and everything you add from here is a choice you made.

Create `~/.config/nvim-mine/init.lua` and add your first lines, one at a time, testing after each:

```lua
vim.opt.number = true
vim.opt.relativenumber = true
```

Then put it under version control. Your editor config is your first personal repository, and everything from the git guide applies to it:

```bash
cd ~/.config/nvim-mine
git init
git add init.lua
git commit -m "First two lines I can explain"
```

The rhythm from now on: feel a friction while working, find the option that removes it, read its `:help`, add the line, commit with a message that says why. One line at a time. Your git log becomes a diary of your taste forming.

**The proof:** your config exists, it is a git repository, it has line numbers plus at least three options you chose yourself, and every commit message says why the line came in.

---

## Rung 5: Your Own Keymaps

The house config binds `Space w` to save. That was somebody's decision about your hands. Now you make those decisions.

First the leader key, the key that starts your personal commands:

```lua
vim.g.mapleader = " "
```

Then bind something:

```lua
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save" })
```

Read it as a sentence: in normal mode (`"n"`), when I press leader then `w`, run the save command, and remember why (`desc`). The `<CR>` is the Enter key.

You may bind the same keys as the house config, but only after Rung 3's rule: you take a line only if you can explain it. Better, notice what you personally do many times a day and shorten it. Running the current test file? Opening the file explorer? A git status glance? Those are the bindings worth having.

The drill: for one week, every time you type the same long command twice in a day, stop and give it a keymap. Commit each one.

**The proof:** five keymaps of your own that you use without thinking, and you can recite what each maps to without opening the file.

---

## Rung 6: Teach It Habits

Options set how the editor is. Keymaps respond when you act. Autocmds act on their own: when a certain event happens, run this code. This rung is your first real Lua.

The house config has a lovely small one. When you copy text, the copied region flashes for a moment, so you always know what you grabbed:

```lua
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 150 })
  end,
})
```

Read it: when the event `TextYankPost` fires (something was just yanked), call this function, which highlights the yanked text for 150 milliseconds. Events have names and Neovim lists them all under `:help autocmd-events`. There are events for opening a file, saving one, changing window, entering insert mode, almost anything.

The drill: browse `:help autocmd-events` and find one event that could remove a friction from your day. The house config uses `BufWritePre` (just before saving) to strip trailing whitespace, and `BufReadPost` (just after opening) to jump to where you last were. Write one autocmd of your own, from scratch, in your config. Break it, read the error, fix it.

**The proof:** one working autocmd you wrote yourself, and you can name its event and say when that event fires.

---

## Rung 7: Earn Your First Plugin

You have worked plugin free for weeks, which means you now know exactly what stock Neovim cannot do. That knowledge is the earning. Most people install twenty plugins first and never learn what any of them replaced.

A plugin is earned when you can honestly say all three:

1. **I can name the pain precisely.** Not "fuzzy finding is cool" but "I lose a minute every time I hunt for a file through the explorer".
2. **I tried living without it.** You gave stock Neovim a real chance to solve it and found its limit.
3. **I read enough of the plugin's documentation to configure it myself.** Not paste a snippet. Read, then write.

When one passes the test, install a plugin manager. The standard one is lazy.nvim, and its README walks you through the bootstrap code. Read that code before you paste it, because the rule has not changed: no line you cannot explain. The bootstrap is a fine Lua reading exercise in itself, and you now know enough to follow it.

Then add your one plugin. Just one. Live with it for a week before you even think about a second. Each new plugin is a dependency, a startup cost, and someone else's decisions entering your editor, so the bar stays high forever.

**The proof:** one installed plugin, and you can say in two sentences what pain it removes and what you tried before it. If your answer would not convince a sceptical pair partner, it does not pass.

---

## Rung 8: Your Workspace

The last rung is not a technique. It is a handover, from the dojo to you.

Finish the surface: pick a colour scheme you actually like (`:colorscheme` and the Tab key will show you the built in ones, and if you have earned a plugin scheme, that counts too). Shape your status line. If your `init.lua` has grown past a screen or two, split it into files under `lua/` and `require` them, and let the structure be as bespoke as the contents.

Then push your repository to your git host and prove the whole point of the ladder: sit down at any machine, run two commands, and be home.

```bash
git clone <your-repo-url> ~/.config/nvim-mine
NVIM_APPNAME=nvim-mine nvim
```

On your own machine you can clone it straight to `~/.config/nvim` and make it the editor, no alias needed. On dojo machines keep it under `nvim-mine`, because the setup script rebuilds the house config at `~/.config/nvim` and will overwrite anything living there.

**The proof:** work one full kata, red, green, refactor, commit, entirely in your own editor, and never reach for the house config once.

---

## After the Ladder

The ladder ends. The rule does not.

Your config will keep growing for years, and every line will face the same question: can you explain it? The day you paste a block you do not understand is the day the editor stops being yours and you start living in somebody else's house again, just one with your name on the door.

You arrived at the dojo and sat down at a machine somebody else had prepared for you. You leave with a workspace you built, understand, and carry in a repository. That was the point all along. The editor was never the lesson. Owning your tools was.
