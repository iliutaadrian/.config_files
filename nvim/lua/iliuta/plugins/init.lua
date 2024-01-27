return {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use

    "christoomey/vim-tmux-navigator", -- tmux & split window navigation
    {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup()
        end,
    },

    {
        "chipsenkbeil/distant.nvim",
        branch = "v0.3",
        config = function()
            require("distant"):setup()
        end,
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
