return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          mappings = {
            i = {
              ["<C-p>"] = actions.move_selection_previous, -- move to prev result
              ["<C-n>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Tab>"] = actions.toggle_selection, -- add this line
            },

            n = {
              ["<C-p>"] = actions.move_selection_previous, -- move to prev result
              ["<C-n>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<Tab>"] = actions.toggle_selection, -- add this line
            },
          },
        },
      })

      telescope.load_extension("fzf")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      keymap.set("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Fuzzy find marks" })
      keymap.set("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Fuzzy find help tags" })
      keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
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
}
