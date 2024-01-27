return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use the latest release instead of the latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --     -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --     -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --     "BufReadPre /Users/iliutaadrian/Life OS/**.md",
    --     "BufNewFile /Users/iliutaadrian/Life OS/**.md",
    -- },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local opts = {
            workspaces = {
                {
                    name = "Life OS",
                    path = "~/Life OS",
                },
            },
            -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
            completion = {
                -- Set to false to disable completion.
                nvim_cmp = true,

                -- Trigger completion at 2 chars.
                min_chars = 2,

                -- Where to put new notes created from completion. Valid options are
                --  * "current_dir" - put new notes in same directory as the current buffer.
                --  * "notes_subdir" - put new notes in the default notes subdirectory.
                new_notes_location = "current_dir",

                -- Control how wiki links are completed with these (mutually exclusive) options:
                --
                -- 1. Whether to add the note ID during completion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                -- Mutually exclusive with 'prepend_note_path' and 'use_path_only'.
                prepend_note_id = true,
                -- 2. Whether to add the note path during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo|Foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'use_path_only'.
                prepend_note_path = false,
                -- 3. Whether to only use paths during completion.
                -- E.g. "[[Foo" completes to "[[notes/foo]]" assuming "notes/foo.md" is the path of the note.
                -- Mutually exclusive with 'prepend_note_id' and 'prepend_note_path'.
                use_path_only = false,
            },
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                ["gf"] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true },
                },
                -- Toggle check-boxes.
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },
            -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
            -- URL it will be ignored but you can customize this behavior here.
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
            -- Optional, configure additional syntax highlighting / extmarks.
            -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
            ui = {
                enable = true, -- set to false to disable all additional syntax features
                update_debounce = 200, -- update delay after a text change (in milliseconds)
                -- Define how various check-boxes are displayed
                checkboxes = {
                    -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
                    [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
                    ["x"] = { char = "", hl_group = "ObsidianDone" },
                    [">"] = { char = "", hl_group = "ObsidianRightArrow" },
                    ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
                    -- Replace the above with this if you don't have a patched font:
                    -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
                    -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

                    -- You can also add more custom ones...
                },
                external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                -- Replace the above with this if you don't have a patched font:
                -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
                reference_text = { hl_group = "ObsidianRefText" },
                highlight_text = { hl_group = "ObsidianHighlightText" },
                tags = { hl_group = "ObsidianTag" },
                hl_groups = {
                    -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
                    ObsidianTodo = { bold = true, fg = "#f78c6c" },
                    ObsidianDone = { bold = true, fg = "#89ddff" },
                    ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
                    ObsidianTilde = { bold = true, fg = "#ff5370" },
                    ObsidianRefText = { underline = true, fg = "#c792ea" },
                    ObsidianExtLinkIcon = { fg = "#c792ea" },
                    ObsidianTag = { italic = true, fg = "#89ddff" },
                    ObsidianHighlightText = { bg = "#75662e" },
                },
            },

            -- Specify how to handle attachments.
            attachments = {
                -- The default folder to place images in via `:ObsidianPasteImg`.
                -- If this is a relative path it will be interpreted as relative to the vault root.
                -- You can always override this per image by passing a full path to the command instead of just a filename.
                img_folder = "assets/imgs", -- This is the default
                -- A function that determines the text to insert in the note when pasting an image.
                -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
                -- This is the default implementation.
                ---@param client obsidian.Client
                ---@param path Path the absolute path to the image file
                ---@return string
                img_text_func = function(client, path)
                    local link_path
                    local vault_relative_path = client:vault_relative_path(path)
                    if vault_relative_path ~= nil then
                        -- Use relative path if the image is saved in the vault dir.
                        link_path = vault_relative_path
                    else
                        -- Otherwise use the absolute path.
                        link_path = tostring(path)
                    end
                    local display_name = vim.fs.basename(link_path)
                    return string.format("![%s](%s)", display_name, link_path)
                end,
            },

            -- Alternatively - and for backward compatibility - you can set 'dir' to a single path instead of
            -- 'workspaces'. For example:
            -- dir = "~/vaults/work",

            -- Optional, set to true to use the current directory as a vault; otherwise
            -- the first workspace is opened by default.
            detect_cwd = false,

            -- Optional, if you keep notes in a specific subdirectory of your vault.
            notes_subdir = "notes",

            -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
            -- levels defined by "vim.log.levels.*".
            log_level = vim.log.levels.INFO,

            -- ... (rest of your configuration)

            yaml_parser = "native", -- Specify how to handle YAML parsing (native or yq).
        }

        require("obsidian").setup(opts)
    end,
}
