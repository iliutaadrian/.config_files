vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.colorscheme = "tokyonight"
vim.opt.conceallevel = 3

local keymap = vim.keymap -- for conciseness

-- disable h, l in normal mode
-- keymap.set("n", "h", "<Nop>")
-- keymap.set("n", "l", "<Nop>")
-- lvim.builtin.which_key.mappings["h"] = nil

-- command line
keymap.set("n", ";", ":<C-f>i", { desc = "Command line" })

-- move paragraph
keymap.set("n", "j", "gj", { desc = "Move down in insert mode" })
keymap.set("n", "k", "gk", { desc = "Move up in insert mode" })

-- new shorcut for move to end/start of line
keymap.set("n", "<C-e>", "$", { desc = "Move to end of line" })
keymap.set("n", "<C-a>", "^", { desc = "Move to start of line" })
keymap.set("i", "<C-e>", "<C-o>$", { desc = "Move to end of line" })
keymap.set("i", "<C-a>", "<C-o>^", { desc = "Move to start of line" })
keymap.set("i", "<M-d>", "<ESC>cW")
keymap.set("i", "<M-b>", "<Esc>Bi")
keymap.set("i", "<M-f>", "<ESC><Space>Wi")

-- clear search highlights
keymap.set("n", "<ESC>", ":nohl<CR><ESC>", { desc = "Clear search highlights" })

-- redo
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- increase
keymap.set("n", "+", "<C-a>", { desc = "Increase number" })
keymap.set("n", "-", "<C-x>", { desc = "Decrease number" })

-- scroll
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- upcase
lvim.builtin.which_key.mappings["u"] = {
  name = "Upcase",
  c = { "~", "Upcase char" },
  w = { "viw~", "Upcase word" },
}

-- refresh file
lvim.builtin.which_key.mappings["rr"] = { "<cmd> e!<CR>", "Refresh file" }

lvim.builtin.which_key.mappings["c"] = {}

-- window management
lvim.builtin.which_key.mappings["s"] = {
  name = "Split",
  v = { "<C-w>v", "Split vertical" },
  h = { "<C-w>s", "Split horizontal" },
  e = { "<C-w>=", "Make splits equal size" },
  m = { "<C-w>_<C-w>|", "Maximize window" },
}

-- increment/decrement window
lvim.builtin.which_key.mappings["="] = { "<cmd>vertical resize +12<CR>", "Increase window size" }
lvim.builtin.which_key.mappings["-"] = { "<cmd>vertical resize -8<CR>", "Decrease window size" }

-- basic file management
lvim.builtin.which_key.mappings["x"] = { "<cmd> qa!<CR>", "Close nvim" }
lvim.builtin.which_key.mappings["W"] = { "<cmd> w<CR>", "Save current buffer" }
lvim.builtin.which_key.mappings["w"] = { "<cmd> noa w<CR>", "Save without formatting" }
lvim.builtin.which_key.mappings["a"] = { "gg<S-v>G", "Select all buffer" }
lvim.builtin.which_key.mappings["q"] = { "<cmd> BufferKill<CR>", "Close current buffer" }

-- search
lvim.builtin.telescope.theme = "center"
lvim.builtin.which_key.mappings["f"] = {
  name = "Telescope",
  C = { "<cmd>Telescope commands<cr>", "Fuzzy find commands" },
  M = { "<cmd>Telescope man_pages<cr>", "Fuzzy find man pages" },
  b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Fuzzy in buffer" },
  c = { "<cmd>Telescope grep_string<cr>", "Find string under cursor in cwd" },
  f = { "<cmd>Telescope find_files<cr>", "Fuzzy find files in cwd" },
  g = { "<cmd>Telescope git_files<cr>", "Find git modifications" },
  h = { "<cmd>Telescope help_tags<cr>", "Fuzzy find help tags" },
  k = { "<cmd>Telescope keymaps<cr>", "Fuzzy find keymaps" },
  m = { "<cmd>Telescope marks<cr>", "Fuzzy find marks" },
  o = { "<cmd>Telescope oldfiles<cr>", "Fuzzy find old files" },
  r = { "<cmd>Telescope resume<cr>", "Resume last search" },
  s = { ":lua require('spectre').open()<CR>", "Spectre" },
  w = { "<cmd>Telescope live_grep<cr>", "Find string in cwd" },
  x = { [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], "Fuzzy replace string in cwd" },
  y = { [[/<C-r><C-w><C-r><C-w><CR>]], "Fuzzy find string in cwd" },
}

lvim.builtin.which_key.mappings["gd"] = {
  ":DiffviewOpen<CR>", "Diiff view open"
}

lvim.builtin.which_key.mappings["gf"] = {
  ":DiffviewFileHistory %<CR>", "File history"
}

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })

-- move on insert
keymap.set("i", "<C-h>", "<left>")
keymap.set("i", "<C-l>", "<right>")
keymap.set("i", "<C-j>", "<down>")
keymap.set("i", "<C-k>", "<up>")

-- keep tab
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Delete into void register
keymap.set({ "n", "v" }, "d", '"_d')
keymap.set({ "n", "v" }, "c", '"_c')
keymap.set({ "n", "v" }, "p", "P", { desc = "Paste without overwriting register" })

lvim.builtin.which_key.mappings["p"] = { "o<Esc>p", "Paste into new line" }
lvim.builtin.which_key.mappings["y"] = { "GVggy", "Yank to clipboard" }

vim.o.makeprg='./build.sh'
lvim.builtin.which_key.mappings["m"] = { ":make<CR>", "Make" }

-- Codeium
vim.g.codeium_no_map_tab = true
keymap.set("i", "<C-c>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
keymap.set("n", "<leader>cd", "<Cmd>CodeiumDisable<CR>", { desc = "Disable codeium" })
keymap.set("n", "<leader>ce", "<Cmd>CodeiumEnable<CR>", { desc = "Enable codeium" })

keymap.set("n", "<leader>oi", ":OrganizeImports<CR>", { desc = "Organize Imports" })

-- Diagnostic messages
vim.diagnostic.config({
  underline = false,
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN, -- Show virtual text only for errors
    },
  },
  signs = {
    severity = {
      min = vim.diagnostic.severity.HINT, -- Show signs for hints and above
    },
  },
})


keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic message" })
keymap.set("n", "D", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open floating diagnostic message" })


lvim.builtin.alpha.active = false
lvim.builtin.indentlines.active = false
-- lvim.builtin.indentlines.options.char = " | "
lvim.builtin.nvimtree.setup.view.width = 52
lvim.builtin.bufferline.options.mode = "buffers"

-- lua/lvim/core/bufferline.lua
-- change all true to false

-- CMP
-- edit cmp mapping on lvim
-- ["<Tab>"] = cmp.mapping.confirm({
--   behavior = cmp.ConfirmBehavior.Insert,
--   select = true,
-- }, { "i", "s" }),

-- Remove format on save for typescript
lvim.format_on_save.enabled = true
lvim.format_on_save.timeout = 4002

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   -- group = "lsp_format_on_save",
--   pattern = "*",
--   callback = function()
--     local file_extension = vim.fn.expand("%:e")
--     print(file_extension)
--     if file_extension ~= "" and (
--           file_extension == "jsx"
--           or file_extension == "js"
--           or file_extension == "tsx"
--           or file_extension == "ts"
--         ) then
--       -- Skip formatting for these file extensions
--       return
--     else
--       -- Apply formatting for other file extensions or no extension
--       require("lvim.lsp.utils").format({ timeout_ms = 2002, filter = require("lvim.lsp.utils").format_filter })
--     end
--   end,
-- })

-- Rubocop
local lspconfig = require('lspconfig')
lspconfig.rubocop.setup {
  cmd = { "rubocop", "--lsp" },
  root_dir = lspconfig.util.root_pattern("Gemfile", ".rubocop.yml", ".git"),
  settings = {
    rubocop = {
      filetypes = { "ruby" },
      -- lint = true,
      autoformat = true,
    }
  },
}

-- Add key mappings for LSP functionality
lvim.lsp.buffer_mappings.normal_mode['gd'] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" }
lvim.lsp.buffer_mappings.normal_mode['gr'] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Go to references" }
lvim.lsp.buffer_mappings.normal_mode['gi'] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" }
lvim.lsp.buffer_mappings.normal_mode['K'] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover information" }


lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    priority = 1002, -- make sure to load this before all the other start plugins
    config = function()
      local bg = "#011630"
      local bg_dark = "#011425"
      local bg_highlight = "#143654"
      local fg = "#CBE2F0"
      local bg_search = "#2A64AC"
      local bg_visual = "#275380"
      local fg_dark = "#B6D0E9"
      local fg_gutter = "#629E97"
      local border = "#548000"

      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "/Users/iliutaadrian/Library/Mobile Documents/iCloud~md~obsidian/Documents/Life OS",
        },
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
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        }
      },
      ui = {
        enable = true,          -- set to false to disable all additional syntax features
        update_debounce = 202,  -- update delay after a text change (in milliseconds)
        max_file_length = 5002, -- disable UI features for files with more than this many lines
        -- Define how various check-boxes are displayed
        checkboxes = {
          -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
          [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
          ["x"] = { char = "", hl_group = "ObsidianDone" },
          [">"] = { char = "", hl_group = "ObsidianRightArrow" },
          ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
          ["!"] = { char = "", hl_group = "ObsidianImportant" },
          -- Replace the above with this if you don't have a patched font:
          -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
          -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

          -- You can also add more custom ones...
        },
        -- Use bullet marks for non-checkbox lists.
        bullets = { char = "•", hl_group = "ObsidianBullet" },
        external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        -- Replace the above with this if you don't have a patched font:
        -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
        reference_text = { hl_group = "ObsidianRefText" },
        highlight_text = { hl_group = "ObsidianHighlightText" },
        tags = { hl_group = "ObsidianTag" },
        block_ids = { hl_group = "ObsidianBlockID" },
        hl_groups = {
          -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          ObsidianTodo = { bold = true, fg = "#f80c6c" },
          ObsidianDone = { bold = true, fg = "#91ddff" },
          ObsidianRightArrow = { bold = true, fg = "#f80c6c" },
          ObsidianTilde = { bold = true, fg = "#ff5372" },
          ObsidianImportant = { bold = true, fg = "#d73130" },
          ObsidianBullet = { bold = true, fg = "#91ddff" },
          ObsidianRefText = { underline = true, fg = "#c794ea" },
          ObsidianExtLinkIcon = { fg = "#c794ea" },
          ObsidianTag = { italic = true, fg = "#91ddff" },
          ObsidianBlockID = { italic = true, fg = "#91ddff" },
          ObsidianHighlightText = { bg = "#75664e" },
        },
      },

    },
  },

  {
    "christoomey/vim-tmux-navigator", -- tmux & split window navigation
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
  },

  {
    "mg981/vim-visual-multi",
    keys = { "<C-n>", "<C-Up>", "<C-Down>" }
  },

  {
    "tpope/vim-surround",
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        -- options used when flsash is activated through
        -- a regular search with `/` or `?`
        search = {
          enabled = true,
        },
        char = {
          enabled = true,
          autohide = true,
        },
      },
    },
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
        "<C-s>",
        mode = { "n", "x", "o" },

        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufEnter",
    keys = {
      -- { "<leader>m", ":lua require('harpoon.mark').add_file()<CR>",        mode = "n", desc = "Mark File" },
      -- { "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", mode = "n", desc = "Harpoon" },
      -- { "<leader>3", ":lua require('harpoon.ui').nav_file(1)<CR>",         mode = "n", desc = "Harpoon 1" },
      -- { "<leader>4", ":lua require('harpoon.ui').nav_file(2)<CR>",         mode = "n", desc = "Harpoon 2" },
      -- { "<leader>5", ":lua require('harpoon.ui').nav_file(3)<CR>",         mode = "n", desc = "Harpoon 3" },
      -- { "<leader>6", ":lua require('harpoon.ui').nav_file(4)<CR>",         mode = "n", desc = "Harpoon 4" },
      { "<leader>bk", "<cmd>BufferLineCloseOthers<CR>",  mode = "n", desc = "Close Other Buffers" },
      { "<leader>1",  "<cmd>BufferLineGoToBuffer 1<CR>", mode = "n", desc = "Harpoon 1" },
      { "<leader>2",  "<cmd>BufferLineGoToBuffer 2<CR>", mode = "n", desc = "Harpoon 2" },
      { "<leader>3",  "<cmd>BufferLineGoToBuffer 3<CR>", mode = "n", desc = "Harpoon 3" },
      { "<leader>4",  "<cmd>BufferLineGoToBuffer 4<CR>", mode = "n", desc = "Harpoon 4" },
      { "<leader>5",  "<cmd>BufferLineGoToBuffer 5<CR>", mode = "n", desc = "Harpoon 5" },
    },
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
          return vim.fn["codeium#CycleCompletions"](3)
        end,
        mode = "i",
        desc = "Cycle Completions",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    priority = 1002,
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {},
          disable_move = { enabled = true },
          packages = { enabled = true },
          footer = {},
        },
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
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
                -- { "~/dev/src4" },
                -- { "~/dev/src5", max_depth = 4 },
                -- { path = "~/dev/src6" },
                -- { path = "~/dev/src7", max_depth = 2 },
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
    "kevinhwang93/nvim-ufo",
    dependencies = "kevinhwang93/promise-async",
    event = "VeryLazy",
    opts = {
      -- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
      provider_selector = function(bufnr, filetype, buftype)
        if filetype == "markdown" or filetype == "yaml" then
          return { "treesitter", "indent" }
        end
      end,
      open_fold_hl_timeout = 402,
      -- close_fold_kinds = { "imports", "comment" },
      offset = -1,
      foldsigns = {
        open = "", --   mark the beginning of a fold
        close = "", --  ↪ show a closed fold
        seps = {
          "▏",
          "▎",
          "▍",
          "▌",
          "▋",
          "▊",
          "▉",
          "█",
        }, -- open fold middle marker -- TODO: ADD MORE
        -- List of all vertical unicode characters: https://en.wikipedia.org/wiki/Box-drawing_character
        --  	"█", "▉", "▊", "▋", "▌", "▍", "▎", "▏",
        --    "│", "║", "┃", "▌", "█"
      },
      preview = {
        win_config = {
          border = { "", "─", "", "", "", "─", "", "" },
          -- winhighlight = "Normal:Folded",
          winblend = 2,
        },
        mappings = {
          scrollU = "<C-u>",
          scrollD = "<C-d>",
          jumpTop = "[",
          jumpBot = "]",
        },
      },
    },
    init = function()
      -- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
      -- vim.o.foldcolumn = "3" -- '0' is not bad
      vim.o.foldlevel = 101 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 101
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(2)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 102)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 2
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[3]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[4]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 4nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 3) - curWidth - sufWidth, 0)
        suffix = (" "):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end
      opts["fold_virt_text_handler"] = handler
      require("ufo").setup(opts)

      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          -- vim.lsp.buf.hover()
          vim.cmd([[ Lspsaga hover_doc ]])
        end
      end)
    end,
  },
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<leader>t",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      ui = {
        position = "center"
      },
    },
  },
  {
    "kchmck/vim-coffee-script",
  },
  { "wakatime/vim-wakatime", lazy = false },

  {
    "sindrets/diffview.nvim",
    event = "BufEnter",
    -- keys = {
    --   { "<leader>gd", ":DiffviewOpen<CR>",          mode = "n", desc = "Diiff view open" },
    --   { "<leader>gf", ":DiffviewFileHistory %<CR>", mode = "n", desc = "File history" },
    -- },
    config = function()
      require("diffview").setup()
    end,
  },
  {
    "echasnovski/mini.ai",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "arnamak/stay-centered.nvim",
    lazy = false,
    opts = {
      skip_filetypes = { 'lua', 'typescript' },
    }
  }
}
