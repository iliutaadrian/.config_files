return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({
        highlight_hovered_item = true,
        show_guides = true,
        auto_preview = false,
        position = "left",
        relative_width = true,
        width = 25,
        auto_close = false,
        show_numbers = false,
        show_relative_numbers = false,
        show_symbol_details = true,
        preview_bg_highlight = "Pmenu",
        autofold_depth = 1,
        auto_unfold_hover = true,
        fold_markers = { "", "" },
        wrap = false,
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
      })
    end,
  },

  {
    "mbbill/undotree",
    event = "BufEnter",
    keys = {
      { "<leader>ut", "<cmd> UndotreeToggle<CR>", mode = "n", desc = "View Undo Tree" },
    },
  },

  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sp", ":lua require('spectre').open()<CR>", mode = "n", desc = "Spectre" },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            jump = {
              pos = "end",
            },
            labels = "fsdghjklweruioncv",
            autojump = true,
            search = {
              mode = function(pattern)
                -- return word pattern and proper skip pattern
                return ([[\<%s\w*\>]]):format(pattern), ([[\<%s]]):format(pattern)
              end,
            },
          })
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },

        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   event = { "BufReadPre", "BufNewFile" },
  --   opts = { indent = { char = "" } },
  -- },

  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>m", ":lua require('harpoon.mark').add_file()<CR>", mode = "n", desc = "Mark File" },
      { "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", mode = "n", desc = "Harpoon" },
      { "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", mode = "n", desc = "Harpoon 1" },
      { "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", mode = "n", desc = "Harpoon 2" },
      { "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", mode = "n", desc = "Harpoon 3" },
      { "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", mode = "n", desc = "Harpoon 4" },
    },
  },
}
