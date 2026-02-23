-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = false

-- Create server socket so external terminals can open files here
vim.fn.mkdir(vim.fn.expand("~/.cache/nvim"), "p")
pcall(vim.fn.serverstart, vim.fn.expand("~/.cache/nvim/server.pipe"))
