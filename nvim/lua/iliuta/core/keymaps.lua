-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab

keymap.set("n", "<leader>ww", "<cmd> w<CR>", { desc = "Save current buffer" })
keymap.set("n", "<leader>qq", "<cmd> qa<CR>", { desc = "Save current buffer" })

--greatest remap ever
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "{zz")
vim.keymap.set("n", "<C-u>", "}zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("i", "<C-h>", "<left>")
vim.keymap.set("i", "<C-l>", "<right>")

-- Delete into void register
vim.keymap.set({ "n", "v" }, "<leader>d", "dd")
vim.keymap.set({ "n", "v" }, "d", '"_d')

-- Paste into new line
vim.keymap.set("n", "<leader>p", "o<Esc>p")

-- Python
vim.api.nvim_set_keymap("n", "<leader>rp", ":w<CR>:!python3 %<CR>", { noremap = true })

-- Codeium
vim.g.codeium_filetypes = {
  python = false,
}
vim.keymap.set("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
vim.keymap.set("i", "<c-[>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true })
vim.keymap.set("i", "<c-]>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true })
vim.keymap.set("i", "<c-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true })

-- bufferline
vim.keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>")
local function closeBuffer()
  local treeView = require("nvim-tree.view")
  local bufferline = require("bufferline")

  -- check if NvimTree window was open
  local explorerWindow = treeView.get_winnr()
  local wasExplorerOpen = vim.api.nvim_win_is_valid(explorerWindow)

  local bufferToDelete = vim.api.nvim_get_current_buf()

  -- TODO: handle modified buffers
  -- local isModified = vim.api.nvim_eval('getbufvar(' .. bufferToDelete .. ', "&mod")')

  if wasExplorerOpen then
    -- switch to previous buffer (tracked by bufferline)
    bufferline.cycle(-1)
  end

  -- delete initially open buffer
  vim.cmd("bdelete! " .. bufferToDelete)
end
vim.keymap.set("n", "<leader>x", closeBuffer)
vim.keymap.set("n", "<leader>bk", "<cmd>BufferLineCloseOthers<CR>")

vim.keymap.set("n", "<leader>oi", ":OrganizeImports<CR>")
vim.keymap.set("n", "<leader>fy", [[/<C-r><C-w><C-r><C-w><CR>]])
vim.keymap.set("n", "<leader>fx", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])
