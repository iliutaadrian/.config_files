# ZSH Setup

## Plugins & Tools

| Tool                  | Trigger                       | Purpose                                        |
| --------------------- | ----------------------------- | ---------------------------------------------- |
| **starship**          | prompt                        | Cross-shell prompt with git status, directory  |
| **zoxide**            | `z <name>`                    | Smart `cd` — learns frequent dirs, fuzzy jumps |
| **fzf**               | `Ctrl+R`, `Ctrl+T`, `**<TAB>` | Fuzzy finder for history, files, completions   |
| **direnv**            | automatic                     | Auto-loads `.envrc` env vars per project       |
| **zapmarks**          | `Ctrl+Z`                      | Command bookmarks — save and search snippets   |
| **zsh-vi-mode**       | installed, unused             | Vi keybindings (replaced by `set -o vi`)       |
| **bash-completion@2** | `<TAB>`                       | System-wide tab completions for tools          |

---

## Aliases

### File System

| Alias | Command                                          | Description                     |
| ----- | ------------------------------------------------ | ------------------------------- |
| `ls`  | `eza -lh --group-directories-first --icons=auto` | Pretty list with icons          |
| `lsa` | `ls -a`                                          | List including hidden files     |
| `lt`  | `eza --tree --level=2 --long --icons --git`      | Tree view                       |
| `lta` | `lt -a`                                          | Tree view including hidden      |
| `ff`  | `fzf --preview 'bat ...'`                        | Fuzzy file finder with preview  |
| `eff` | `$EDITOR $(ff)`                                  | Open fuzzy-found file in editor |
| `..`  | `cd ..`                                          | Go up one directory             |

### Navigation

| Alias | Command | Description                                 |
| ----- | ------- | ------------------------------------------- |
| `cd`  | `zd()`  | Smart cd via zoxide (falls back to builtin) |

### Tools

| Alias | Command                                 | Description                         |
| ----- | --------------------------------------- | ----------------------------------- |
| `c`   | `clear`                                 | Clear terminal                      |
| `cx`  | `claude --dangerously-skip-permissions` | Claude AI with full permissions     |
| `lg`  | `lazygit`                               | Terminal git UI                     |
| `t`   | `tmux attach \|\| tmux new -s Work`     | Attach or create tmux session       |
| `x`   | `exit 0`                                | Exit shell                          |
| `n`   | `nvim .` or `nvim <file>`               | Open nvim (current dir if no args)  |
| `nv`  | `nvim --server ... --remote`            | Open file in existing nvim instance |

### Personal

| Alias   | Command                          | Description      |
| ------- | -------------------------------- | ---------------- |
| `nz`    | `cd && lvim ~/.zshrc`            | Edit zshrc       |
| `nt`    | `cd && lvim ~/.tmux.conf`        | Edit tmux config |
| `src`   | `source ~/.zshrc`                | Reload zshrc     |
| `query` | `python $HOME/.tinyquery/app.py` | Run tinyquery    |

---

## Functions

| Function                | Usage                          | Description                                       |
| ----------------------- | ------------------------------ | ------------------------------------------------- |
| `zd`                    | `cd <dir>`                     | Smart cd — home if no args, zoxide if unknown dir |
| `n`                     | `n [file]`                     | nvim wrapper — opens `.` if no args               |
| `nv`                    | `nv <file>`                    | Open in existing nvim server instance             |
| `yy`                    | `yy [path]`                    | Yazi file manager, changes cwd on exit            |
| `cc`                    | `cc`                           | Clear terminal + tmux history                     |
| `compress`              | `compress <dir>`               | tar.gz a directory                                |
| `decompress`            | `decompress <file>`            | Extract tar.gz                                    |
| `transcode-video-1080p` | `transcode-video-1080p <file>` | FFmpeg encode to 1080p H.264                      |
| `transcode-video-4K`    | `transcode-video-4K <file>`    | FFmpeg encode to 4K H.265                         |
| `img2jpg`               | `img2jpg <file>`               | Convert image to high-quality JPG                 |
| `img2jpg-small`         | `img2jpg-small <file>`         | Convert + resize to max 1080px wide               |
| `img2jpg-medium`        | `img2jpg-medium <file>`        | Convert + resize to max 1800px wide               |
| `img2png`               | `img2png <file>`               | Convert image to optimized PNG                    |
| `fip`                   | `fip <host> <port...>`         | SSH port forward one or more ports                |
| `dip`                   | `dip <port...>`                | Stop SSH port forward(s)                          |
| `lip`                   | `lip`                          | List active SSH port forwards                     |
| `nic`                   | `nic [ai]`                     | Open tmux dev layout: editor + AI + terminal      |
| `unnic`                 | `unnic`                        | Close current tmux window, open fresh one         |

---

## History

- Deduplication: `HIST_IGNORE_ALL_DUPS`
- Ignored commands: `cd`, `ls`, `ll`, `lsa`, `rm -rf`, `exit`, `x`, `c`, `cc`
- Prefix command with a space to skip saving it (`HIST_IGNORE_SPACE`)
- Size: 32,768 entries

---

## Zapmarks (saved commands)

Access with `Ctrl+Z`, search by description.

| Command                                                | Description                       |
| ------------------------------------------------------ | --------------------------------- |
| `source ~/.tmux.conf`                                  | Reload tmux configuration         |
| `tmux attach -d`                                       | Reattach to tmux session          |
| `docker compose build && docker compose up -d`         | Build and start Docker containers |
| `rails s`                                              | Start Rails server                |
| `git push deployment feature/ggstest:ggstest_deploy`   | Deploy to ggstest                 |
| `git push deployment feature/ggstest2:ggstest2_deploy` | Deploy to ggstest2                |
| `git push -f deployment quick-deploy:quick-deploy`     | Force deploy quick-deploy         |
| `du -sh * \| sort -rh \| head -n 10`                   | Show 10 largest files/dirs        |
| `docker exec -it [container] /bin/bash`                | Exec bash in container            |
| `zapmarks-add`                                         | Add a new bookmark                |
| `zapmarks-edit`                                        | Edit bookmarks file               |
