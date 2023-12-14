return {
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  "christoomey/vim-tmux-navigator", -- tmux & split window navigation

  {
    "NeogitOrg/neogit",

    keys = {
      {
        "<leader>gg",
        "<cmd> Neogit<CR>",
        mode = "n",
        desc = "Open Neogit",
      },
    },

    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },

    config = function(_, opts)
      require("neogit").setup(opts)
    end,

    opts = {},
  },
  {
    "exafunction/codeium.vim",
    event = "BufEnter",
  },
  {
    "mbbill/undotree",
    keys = {
      { "<leader>ut", "<cmd> UndotreeToggle<CR>", mode = "n", desc = "View Undo Tree" },
    },
  },
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
  { -- Telescope projects
    -- Migrated to project.nvim
    "nvim-telescope/telescope-project.nvim",

    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        opts = {
          extensions = {
            project = {
              base_dirs = {
                "~/Github",
                "~/",
                -- { "~/dev/src2" },
                -- { "~/dev/src3", max_depth = 4 },
                -- { path = "~/dev/src4" },
                -- { path = "~/dev/src5", max_depth = 2 },
              },
              -- hidden_files = true, -- default: false --- .git files go brrr
              theme = "dropdown",
              order_by = "recent",
              search_by = "title",
              sync_with_nvim_tree = true, -- default false
              -- default for on_project_selected = find project files
              on_project_selected = function(prompt_bufnr)
                local project_actions = require("telescope._extensions.project.actions")
                project_actions.change_working_directory(prompt_bufnr, false)
              end,
            },
          },
        },
      },
    },

    keys = {
      {
        "<leader>fp",
        "<cmd>lua require'telescope'.extensions.project.project{ display_type = 'full' }<CR>",
        desc = "Find Project",
      },
    },

    config = function()
      local project_actions = require("telescope._extensions.project.actions")
      require("telescope").load_extension("project")
    end,
  },
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sp", ":lua require('spectre').open()<CR>", mode = "n", desc = "Spectre" },
    },
  },
  { -- Built-in cheats
    -- AWESOME
    "sudormrfbin/cheatsheet.nvim",

    cmd = { "Cheatsheet" },

    keys = {
      {
        "<leader>fi",
        "<cmd>Cheatsheet<cr>",
        mode = "n",
        desc = "Find Cheat",
      },
    },

    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
}
