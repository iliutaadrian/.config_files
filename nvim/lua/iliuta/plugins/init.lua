return {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use

    "christoomey/vim-tmux-navigator", -- tmux & split window navigation
    "MunifTanjim/nui.nvim",
    {
        "declancm/cinnamon.nvim",
        requires = { "MunifTanjim/nui.nvim" },
        config = function()
            require("cinnamon").setup()
        end,
    },
    {
        "VonHeikemen/fine-cmdline.nvim",
        config = function()
            require("fine-cmdline").setup()
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup({
                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = false,
                position = "right",
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

    { -- Built-in cheats
        -- AWESOME
        "sudormrfbin/cheatsheet.nvim",

        cmd = { "Cheatsheet" },

        opts = {
            bundled_cheatsheets = {
                enabled = true,
            },
            bundled_plugin_cheatsheets = {
                enabled = false,
            },
        },

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
}
