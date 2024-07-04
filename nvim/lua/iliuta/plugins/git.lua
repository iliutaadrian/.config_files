return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
    current_line_blame = true,
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    keys = {
      {
        "]h",
        function()
          if vim.wo.diff then
            return "]h"
          end
          vim.schedule(function()
            require("gitsigns").next_hunk()
          end)
          return "<Ignore>"
        end,
        expr = true,
      },
      {
        "[h",
        function()
          if vim.wo.diff then
            return "[h"
          end
          vim.schedule(function()
            require("gitsigns").prev_hunk()
          end)
          return "<Ignore>"
        end,
        expr = true,
      },
      { "<leader>gr", ":Gitsigns reset_hunk<CR>" },
      { "<leader>gR", ":Gitsigns reset_buffer<CR>" },
      { "<leader>gb", ":Gitsigns blame_line<CR>" },
      { "[c", ":Gitsigns prev_hunk<CR>" },
      { "]c", ":Gitsigns next_hunk<CR>" },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", mode = "n", desc = "Open LazyGit" },
    },
    -- config = function()
    --     require("lazygit").setup()
    -- end,
  },

  {
    "exafunction/codeium.vim",
    event = "BufEnter",
    keys = {
      -- {
      --     "<C-c>",
      --     function()
      --         return vim.fn["codeium#Accept"]()
      --     end,
      --     mode = "i",
      --     desc = "Accept",
      -- },
      {
        "<C-x>",
        function()
          return vim.fn["codeium#Clear"]()
        end,
        mode = "i",
        desc = "Clear",
      },
      {
        "<C-f>",
        function()
          return vim.fn["codeium#CycleCompletions"](1)
        end,
        mode = "i",
        desc = "Cycle Completions",
      },
    },
  },

  -- {
  --   "supermaven-inc/supermaven-nvim",
  --   config = function()
  --     require("supermaven-nvim").setup({
  --       -- your configuration here
  --       keymaps = {
  --         accept_suggestion = "<C-c>",
  --         clear_suggestion = "<C-x>",
  --       },
  --     })
  --   end,
  -- },

  {
    "sindrets/diffview.nvim",
    event = "BufEnter",
    keys = {
      { "<leader>gd", ":DiffviewOpen<CR>", mode = "n", desc = "Diiff view open" },
      { "<leader>gf", ":DiffviewFileHistory %<CR>", mode = "n", desc = "File history" },
    },
    config = function()
      require("diffview").setup()
    end,
  },
}
