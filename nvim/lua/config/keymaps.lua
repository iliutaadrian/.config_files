-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Save (replacing C-s which is tmux prefix)
vim.keymap.set({ "n", "i", "v" }, "<leader>W", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Remove LazyVim's C-s save (conflicts with tmux prefix)
vim.keymap.del({ "n", "i", "v" }, "<C-s>")

-- Move text up/down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- End/start of line
vim.keymap.set({ "n", "i" }, "<C-e>", "<C-o>$", { desc = "Move to end of line" })
vim.keymap.set({ "n", "i" }, "<C-a>", "<C-o>^", { desc = "Move to start of line" })

-- Insert mode word navigation
vim.keymap.set("i", "<C-d>", "<ESC>cW", { desc = "Delete word forward" })
vim.keymap.set("i", "<C-b>", "<Esc>Bi", { desc = "Word backward" })
vim.keymap.set("i", "<C-f>", "<ESC><Space>Wi", { desc = "Word forward" })

-- Arrow movement in insert mode (only insert, no conflict with tmux navigator in normal mode)
vim.keymap.set("i", "<C-h>", "<left>",  { desc = "Move left" })
vim.keymap.set("i", "<C-l>", "<right>", { desc = "Move right" })
vim.keymap.set("i", "<C-j>", "<down>",  { desc = "Move down" })
vim.keymap.set("i", "<C-k>", "<up>",    { desc = "Move up" })

-- Reload current file
vim.keymap.set("n", "<leader>rr", "<cmd>e!<CR>", { desc = "Reload file" })

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })
