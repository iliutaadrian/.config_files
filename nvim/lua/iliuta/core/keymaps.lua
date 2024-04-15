-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

----------------------- General Keymaps -------------------

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
-- keymap.set("i", "<ESC>", "<ESC>", { desc = "Exit insert mode with ESC" })

keymap.set("n", "j", "gj", { desc = "Move down in insert mode" })
keymap.set("n", "k", "gk", { desc = "Move up in insert mode" })

-- clear search highlights
keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- upcase
keymap.set("n", "<leader>uc", "~", { noremap = true, silent = true, desc = "Upcase char" })
keymap.set("n", "<leader>uw", "viw~", { noremap = true, silent = true, desc = "Upcase word" })
keymap.set("v", "<leader>up", "~", { noremap = true, silent = true, desc = "Upcase selection" })

-- refresh file
keymap.set("n", "<leader>rr", ":e!<CR>", { desc = "Refresh file" })

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
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "{zz")
keymap.set("n", "<C-u>", "}zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")
keymap.set("n", "<C-a>", "gg<S-v>G")

-- move on insert
keymap.set("i", "<C-h>", "<left>")
keymap.set("i", "<C-l>", "<right>")
keymap.set("i", "<C-j>", "<down>")
keymap.set("i", "<C-k>", "<up>")

-- keep tab
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Delete into void register
keymap.set({ "n", "v" }, "<leader>d", "dd")
keymap.set({ "n", "v" }, "d", '"_d')

-- Paste into new line
keymap.set("n", "<leader>p", "o<Esc>p")

-- Find and replace word under cursor
keymap.set("n", "<leader>fy", [[/<C-r><C-w><C-r><C-w><CR>]], { desc = "Find word under cursor" })
keymap.set(
    "n",
    "<leader>fx",
    [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Find and replace word under cursor" }
)

-- Advanced with plugins
--
-- Python
vim.api.nvim_set_keymap("n", "<leader>rp", ":w<CR>:!python3 %<CR>", { noremap = true })

-- Codeium
vim.g.codeium_no_map_tab = true
keymap.set("i", "<C-c>", function()
    return vim.fn["codeium#Accept"]()
end, { expr = true })

-- SymbolsOutline
keymap.set("n", "<leader>fs", ":SymbolsOutline<CR>", { noremap = true })

-- bufferline
keymap.set("n", "<tab>", "<cmd>BufferLineCycleNext<CR>")
keymap.set("n", "<S-tab>", "<cmd>BufferLineCyclePrev<CR>")
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
keymap.set("n", "<leader>x", closeBuffer)
keymap.set("n", "<leader>bk", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

keymap.set("n", "<leader>oi", ":OrganizeImports<CR>", { desc = "Organize Imports" })
