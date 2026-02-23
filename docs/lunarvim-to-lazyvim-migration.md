<!-- markdownlint-disable MD013 -->

# LunarVim to LazyVim Migration Report

## 1. Editor Options

| Setting           | LunarVim (current)                            | LazyVim (new)                     |
| ----------------- | --------------------------------------------- | --------------------------------- |
| Relative numbers  | `vim.opt.relativenumber = true`               | Built-in default (already on)     |
| Line wrap         | `vim.opt.wrap = true`                         | Off by default, needs adding      |
| Conceal level     | `vim.opt.conceallevel = 3`                    | Already set to 3 by LazyVim       |
| Format on save    | `lvim.format_on_save.enabled = true` (4002ms) | Via `conform.nvim` (needs config) |
| Fold level        | `vim.o.foldlevel = 101`                       | LazyVim sets `foldlevel = 99`     |
| Treesitter indent | Disabled                                      | Enabled by default                |

---

## 2. Colorscheme

|               | LunarVim                                                               | LazyVim                                         |
| ------------- | ---------------------------------------------------------------------- | ----------------------------------------------- |
| Theme         | **tokyonight** (night, heavily customized)                             | **tokyonight** (default) + catppuccin available |
| Custom colors | Deep blue bg (`#011630`), custom fg/gutter/border/visual/search colors | None yet                                        |

**Action needed:** Port your custom tokyonight color overrides to a LazyVim plugin spec.

---

## 3. Plugin Comparison

### 3.1 Shared / Equivalent Plugins (already in both)

| Feature      | LunarVim plugin                         | LazyVim plugin                    | Notes                                                |
| ------------ | --------------------------------------- | --------------------------------- | ---------------------------------------------------- |
| Fuzzy finder | telescope.nvim                          | **snacks.nvim** (picker)          | LazyVim uses snacks picker by default, not telescope |
| File tree    | nvim-tree.lua                           | **snacks.nvim** (explorer)        | Different UI, similar function                       |
| Statusline   | lualine.nvim                            | lualine.nvim                      | Same                                                 |
| Bufferline   | bufferline.nvim                         | bufferline.nvim                   | Same                                                 |
| Git signs    | gitsigns.nvim                           | gitsigns.nvim                     | Same                                                 |
| Treesitter   | nvim-treesitter + textobjects           | nvim-treesitter + textobjects     | Same                                                 |
| LSP          | nvim-lspconfig + mason                  | nvim-lspconfig + mason            | Same                                                 |
| Which-key    | which-key.nvim                          | which-key.nvim                    | Same                                                 |
| Flash/jump   | flash.nvim                              | flash.nvim                        | Same                                                 |
| Snippets     | LuaSnip + friendly-snippets             | friendly-snippets (via blink.cmp) | Different engine                                     |
| Completion   | nvim-cmp                                | **blink.cmp**                     | Different, blink.cmp is faster                       |
| Auto pairs   | nvim-autopairs                          | **mini.pairs**                    | Different plugin, same purpose                       |
| Text objects | mini.ai                                 | mini.ai                           | Same                                                 |
| Comments     | Comment.nvim + ts-context-commentstring | **ts-comments.nvim**              | Different plugin, same purpose                       |
| Formatting   | none-ls.nvim                            | **conform.nvim**                  | Different approach                                   |
| Linting      | (via none-ls)                           | **nvim-lint**                     | Separate linting in LazyVim                          |

### 3.2 Plugins in LunarVim that are MISSING from LazyVim (need to add)

| Plugin                                  | Purpose                                               | Priority                                                    |
| --------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------------- |
| `epwalsh/obsidian.nvim`                 | Obsidian vault integration (Life OS workspace)        | **High** - daily use                                        |
| `christoomey/vim-tmux-navigator`        | Tmux split navigation                                 | **High** - workflow critical                                |
| `exafunction/codeium.vim`               | AI code completion                                    | **High** - daily use                                        |
| `mbbill/undotree`                       | Visual undo history                                   | **Medium**                                                  |
| `nvim-pack/nvim-spectre`                | Search & replace across files                         | **Medium** (LazyVim has `grug-far.nvim` as replacement)     |
| `tpope/vim-surround`                    | Surround motions (cs, ds, ys)                         | **Medium** (LazyVim has `mini.surround` available as extra) |
| `nvim-telescope/telescope-project.nvim` | Project switcher (`~/Github`)                         | **Medium** (LazyVim has `persistence.nvim` for sessions)    |
| `kevinhwang91/nvim-ufo`                 | Advanced code folding                                 | **Medium**                                                  |
| `sindrets/diffview.nvim`                | Git diff viewer                                       | **Medium**                                                  |
| `leath-dub/snipe.nvim`                  | Quick buffer menu                                     | **Low** (bufferline covers this)                            |
| `ThePrimeagen/harpoon`                  | Buffer marking (mostly unused, using bufferline goto) | **Low**                                                     |
| `nvimdev/dashboard-nvim`                | Start screen                                          | **Low** (LazyVim has `snacks.nvim` dashboard)               |
| `kchmck/vim-coffee-script`              | CoffeeScript syntax                                   | **Low**                                                     |
| `wakatime/vim-wakatime`                 | Time tracking                                         | **Low** - background                                        |
| `arnamak/stay-centered.nvim`            | Keep cursor centered                                  | **Low**                                                     |

### 3.3 Plugins NEW in LazyVim (you gain for free)

| Plugin                          | Purpose                                                            |
| ------------------------------- | ------------------------------------------------------------------ |
| `folke/noice.nvim` + `nui.nvim` | Better UI for messages, cmdline, popups                            |
| `folke/trouble.nvim`            | Better diagnostics list                                            |
| `folke/todo-comments.nvim`      | Highlight TODO/FIXME/HACK comments                                 |
| `folke/snacks.nvim`             | Swiss army knife: dashboard, picker, explorer, notifications, etc. |
| `folke/persistence.nvim`        | Session management (auto-save/restore)                             |
| `grug-far.nvim`                 | Modern search & replace (replaces spectre)                         |
| `nvim-lint`                     | Async linting (separate from formatter)                            |
| `nvim-ts-autotag`               | Auto close/rename HTML tags                                        |
| `lazydev.nvim`                  | Lua dev support (replaces neodev)                                  |
| `mini.icons`                    | Icon provider                                                      |

---

## 4. Keybinding Comparison

### 4.1 Custom keymaps you NEED to port

| Keymap              | Mode  | Action                         | LazyVim default                         |
| ------------------- | ----- | ------------------------------ | --------------------------------------- |
| `<Tab>` / `<S-Tab>` | n     | Buffer cycle next/prev         | `<S-h>` / `<S-l>` (different keys)      |
| `;`                 | n     | Command line (`:<C-f>i`)       | Not mapped                              |
| `j` / `k`           | n     | `gj` / `gk` (visual lines)     | Not mapped (standard j/k)               |
| `K` / `J`           | v     | Move text up/down              | `<A-j>` / `<A-k>` (Alt+j/k in LazyVim)  |
| `<C-e>` / `<C-a>`   | n,i   | End/start of line              | Not mapped                              |
| `<C-d>`             | i     | Delete word forward            | Not mapped                              |
| `<C-b>` / `<C-f>`   | i     | Word back/forward              | Not mapped                              |
| `U`                 | n     | Redo (`<C-r>`)                 | Not mapped                              |
| `+` / `-`           | n     | Increment/decrement            | Not mapped                              |
| `<C-d>` / `<C-u>`   | n     | Scroll + center (zz)           | Standard scroll (no centering)          |
| `d` / `c`           | n,v   | Delete/change to void register | Standard (overwrites register)          |
| `p`                 | n,v   | Paste without overwrite (`P`)  | Standard paste                          |
| `<C-h/l/j/k>`       | i     | Arrow movement in insert       | Window navigation (conflict!)           |
| `<ESC>`             | n     | Clear search highlights        | LazyVim already does this               |
| `<leader>w`         | n     | Save without formatting        | LazyVim uses `<leader>w` for windows    |
| `<leader>W`         | n     | Save with formatting           | Not mapped                              |
| `<leader>q`         | n     | Close buffer (BufferKill)      | LazyVim uses `<leader>q` for quit       |
| `<leader>x`         | n     | Quit nvim (`qa!`)              | LazyVim uses `<leader>x` for trouble    |
| `<leader>a`         | n     | Select all                     | Not mapped                              |
| `<leader>f`         | n     | Telescope group                | LazyVim uses `<leader>f` for find files |
| `<leader>s`         | n     | Split management               | LazyVim uses `<leader>s` for search     |
| `<leader>p`         | n     | Paste new line                 | Not mapped                              |
| `<leader>y`         | n     | Yank all to clipboard          | Not mapped                              |
| `<leader>m`         | n     | Make (build.sh)                | Not mapped                              |
| `<leader>t`         | n     | Snipe buffer menu              | LazyVim uses `<leader>t` for terminal   |
| `<leader>1-5`       | n     | Go to buffer 1-5               | LazyVim uses for which-key layers       |
| `<leader>bk`        | n     | Close other buffers            | `<leader>bo` in LazyVim                 |
| `<leader>gd`        | n     | Diffview open                  | Not mapped                              |
| `<leader>gf`        | n     | File history                   | Not mapped                              |
| `<leader>rr`        | n     | Refresh file                   | Not mapped                              |
| `<leader>u`         | n     | Upcase submenu                 | LazyVim uses `<leader>u` for UI toggles |
| `D`                 | n     | Float diagnostic               | Not mapped                              |
| `<C-c>`             | i     | Codeium accept                 | Not mapped                              |
| `s`                 | n,x,o | Flash jump (custom pattern)    | Flash jump (different config)           |
| `<C-s>`             | n,x,o | Flash treesitter               | `S` in LazyVim                          |

### 4.2 Major leader key CONFLICTS to resolve

| Key         | Your current use    | LazyVim default use     |
| ----------- | ------------------- | ----------------------- |
| `<leader>w` | Save without format | **Window management**   |
| `<leader>q` | Close buffer        | **Quit/session**        |
| `<leader>x` | Quit nvim           | **Trouble diagnostics** |
| `<leader>s` | Split management    | **Search (grep, etc.)** |
| `<leader>u` | Upcase              | **UI toggles**          |
| `<leader>t` | Snipe buffer        | **Terminal**            |

---

## 5. LSP Configuration

|                  | LunarVim                                               | LazyVim                      |
| ---------------- | ------------------------------------------------------ | ---------------------------- |
| Rubocop (Ruby)   | Manually configured via lspconfig                      | Need to add via mason config |
| Diagnostics      | Custom: virtual text WARN+, signs HINT+, underline off | Default: all on              |
| Organize imports | `<leader>oi` custom keymap                             | Not configured               |

---

## 6. Snippets

| Snippet | Language   | Body              |
| ------- | ---------- | ----------------- |
| `cl`    | JavaScript | `console.log($0)` |
| `binp`  | Ruby       | `binding.pry`     |

These need to be copied to `~/.config/nvim/snippets/`.

---

## 7. Migration Summary

### Easy wins (already covered by LazyVim)

- Flash, mini.ai, gitsigns, treesitter, LSP, mason, bufferline, lualine, which-key
- Search & replace (grug-far replaces spectre)
- Clear search on ESC, Alt+j/k for moving lines

### Must port (custom behavior you rely on)

1. Tokyonight custom color scheme
2. Void register `d`/`c`/`p` remaps
3. Insert mode navigation (`C-e`, `C-a`, `C-h/l/j/k`, `C-b`, `C-f`, `C-d`)
4. `U` for redo, `+`/`-` for increment
5. Scroll centering (`C-d`/`C-u` + zz)
6. Tab/S-Tab buffer cycling
7. `;` for command line
8. Buffer number navigation (`leader 1-5`)

### Must add as plugins

1. `codeium.vim` (or switch to Copilot which has a LazyVim extra)
2. `vim-tmux-navigator`
3. `obsidian.nvim`
4. `diffview.nvim`
5. `nvim-ufo` (if you want folding)
6. `vim-wakatime`
7. `stay-centered.nvim`

### Must resolve leader conflicts

Remap `<leader>w/q/x/s/u/t` to avoid clashing with LazyVim defaults, or override LazyVim's defaults with yours.
