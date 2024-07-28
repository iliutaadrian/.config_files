-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.relativenumber = true
vim.opt.wrap = true

local keymap = vim.keymap -- for conciseness

keymap.set("n", "j", "gj", { desc = "Move down in insert mode" })
keymap.set("n", "k", "gk", { desc = "Move up in insert mode" })

-- clear search highlights
keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "Clear search highlights" })

-- redo
keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- upcase
lvim.builtin.which_key.mappings["u"] = {
  name = "Upcase",
  c = { "~", "Upcase char" },
  w = { "viw~", "Upcase word" },
  p = { "~", "Upcase selection" }
}

-- refresh file
lvim.builtin.which_key.mappings['rr'] = { "<cmd> e!<CR>", "Refresh file" }

lvim.builtin.which_key.mappings['c'] = {}

-- window management
lvim.builtin.which_key.mappings['s'] = {
  name = "Split",
  v = { "<C-w>v", "Split vertical" },
  h = { "<C-w>s", "Split horizontal" },
  e = { "<C-w>=", "Make splits equal size" }
}

-- increment/decrement window
lvim.builtin.which_key.mappings['='] = { "<cmd>vertical resize +10<CR>", "Increase window size" }
lvim.builtin.which_key.mappings['-'] = { "<cmd>vertical resize -10<CR>", "Decrease window size" }

-- basic file management
lvim.builtin.which_key.mappings['x'] = { "<cmd> qa!<CR>", "Close nvim" }
lvim.builtin.which_key.mappings['w'] = { "<cmd> w<CR>", "Save current buffer" }
lvim.builtin.which_key.mappings['W'] = { "<cmd> noa w<CR>", "Save without formatting" }
lvim.builtin.which_key.mappings['a'] = { "<cmd> wa<CR>", "Save all buffers" }
lvim.builtin.which_key.mappings['q'] = { "<cmd> q<CR>", "Close current buffer" }

-- search
lvim.builtin.telescope.theme = "center"
lvim.builtin.which_key.mappings['f'] = {
  name = "Telescope",
  C = { "<cmd>Telescope commands<cr>", "Fuzzy find commands" },
  M = { "<cmd>Telescope man_pages<cr>", "Fuzzy find man pages" },
  b = { "<cmd>Telescope buffers<cr>", "Fuzzy find buffers" },
  c = { "<cmd>Telescope grep_string<cr>", "Find string under cursor in cwd" },
  f = { "<cmd>Telescope find_files<cr>", "Fuzzy find files in cwd" },
  h = { "<cmd>Telescope help_tags<cr>", "Fuzzy find help tags" },
  k = { "<cmd>Telescope keymaps<cr>", "Fuzzy find keymaps" },
  m = { "<cmd>Telescope marks<cr>", "Fuzzy find marks" },
  r = { "<cmd>Telescope resume<cr>", "Resume last search" },
  w = { "<cmd>Telescope live_grep<cr>", "Find string in cwd" },
  o = { "<cmd>Telescope oldfiles<cr>", "Fuzzy find old files" },
  y = { [[/<C-r><C-w><C-r><C-w><CR>]], "Fuzzy find string in cwd" },
  x = { [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], "Fuzzy replace string in cwd" },
  s = { ":lua require('spectre').open()<CR>", "Spectre" }
}

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
keymap.set("i", "<C-k>", "<down>")

-- keep tab
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Delete into void register
keymap.set({ "n", "v" }, "d", '"_d')
keymap.set({ "n", "v" }, "c", '"_c')
keymap.set({ "n", "v" }, "p", "P", { desc = "Paste without overwriting register" })

lvim.builtin.which_key.mappings["p"] = { "o<Esc>p", "Paste into new line" }
lvim.builtin.which_key.mappings["y"] = { "GVggy", "Yank to clipboard" }

-- Python
vim.api.nvim_set_keymap("n", "<leader>rp", ":w<CR>:!python3 %<CR>", { noremap = true })

-- Codeium
vim.g.codeium_no_map_tab = true
keymap.set("i", "<C-c>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true })
keymap.set("n", "<leader>cd", "<Cmd>CodeiumDisable<CR>", { desc = "Disable codeium" })
keymap.set("n", "<leader>ce", "<Cmd>CodeiumEnable<CR>", { desc = "Enable codeium" })

keymap.set("n", "<leader>bk", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close other buffers" })

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

-- Remove format on save for typescript
lvim.format_on_save = false
vim.api.nvim_create_autocmd("BufWritePre", {
  -- group = "lsp_format_on_save",
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" or vim.bo.filetype == "javascriptreact" or
        vim.bo.filetype == "typescriptreact"
    then
      require("lvim.lsp.utils").format { timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter }
      return
    else
      require("lvim.lsp.utils").format { timeout_ms = 2000, filter = require("lvim.lsp.utils").format_filter }
    end
  end,
})

keymap.set("n", "[d]", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", { desc = "Go to next diagnostic message" })
keymap.set("n", "D", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Open floating diagnostic message" })

lvim.builtin.dap.active = false
lvim.builtin.alpha.active = false
lvim.builtin.indentlines.active = false
-- lvim.builtin.indentlines.options.char = " | "
lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.bufferline.options.mode = "tabs"

-- lua/lvim/core/bufferline.lua
-- change all true to false
--
-- cmp
-- edit cmp mapping on lvim
-- ["<Tab>"] = cmp.mapping.confirm({
--   behavior = cmp.ConfirmBehavior.Insert,
--   select = true,
-- }, { "i", "s" }),

lvim.colorscheme = "tokyonight"

lvim.plugins = {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local fg = "#CBE0F0"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

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
    "stevearc/dressing.nvim",
    config = function()
      require("dressing").setup({
        input = { enabled = false },
      })
    end,
  },
  "christoomey/vim-tmux-navigator", -- tmux & split window navigation
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
    "tpope/vim-surround",
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

  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>m", ":lua require('harpoon.mark').add_file()<CR>",        mode = "n", desc = "Mark File" },
      { "<leader>h", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", mode = "n", desc = "Harpoon" },
      { "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>",         mode = "n", desc = "Harpoon 1" },
      { "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>",         mode = "n", desc = "Harpoon 2" },
      { "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>",         mode = "n", desc = "Harpoon 3" },
      { "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>",         mode = "n", desc = "Harpoon 4" },
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
          return vim.fn["codeium#CycleCompletions"](1)
        end,
        mode = "i",
        desc = "Cycle Completions",
      },
    },
  },
  {
    "nvimdev/dashboard-nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("dashboard").setup({
        theme = "hyper",
        config = {
          header = {
            "o 8  o          o                .oo      8        o              ",
            "8 8             8               .P 8      8                       ",
            "8 8 o8 o    o  o8P .oPYo.      .P  8 .oPYo8 oPYo. o8 .oPYo. odYo. ",
            "8 8  8 8    8   8  .oooo8     oPooo8 8    8 8  `'  8 .oooo8 8' `8 ",
            "8 8  8 8    8   8  8    8    .P    8 8    8 8      8 8    8 8   8 ",
            "8 8  8 `YooP'   8  `YooP8   .P     8 `YooP' 8      8 `YooP8 8   8 ",
            "....:..:.....:::..::.....:::..:::::..:.....:..:::::..:.....:..::..",
          },
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
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    opts = {
      -- INFO: Uncomment to use treeitter as fold provider, otherwise nvim lsp is used
      provider_selector = function(bufnr, filetype, buftype)
        if filetype == "markdown" or filetype == "yaml" then
          return { "treesitter", "indent" }
        end
      end,
      open_fold_hl_timeout = 400,
      -- close_fold_kinds = { "imports", "comment" },
      offset = -3,
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
          winblend = 0,
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
      -- vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    config = function(_, opts)
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = ("  %d %d%%"):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
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
    "kchmck/vim-coffee-script",
  },
  {
    "tpope/vim-rails",
    cmd = {
      "Eview",
      "Econtroller",
      "Emodel",
      "Smodel",
      "Sview",
      "Scontroller",
      "Vmodel",
      "Vview",
      "Vcontroller",
      "Tmodel",
      "Tview",
      "Tcontroller",
      "Rails",
      "Generate",
      "Runner",
      "Extract"
    }
  },
  { 'wakatime/vim-wakatime', lazy = false },

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
      neoscroll = require('neoscroll')
      local keymap = {
        ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end,
        ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end,
        ["<C-i>"] = function() neoscroll.scroll(-0.3, { move_cursor = true, duration = 100 }) end,
        ["<C-u>"] = function() neoscroll.scroll(0.3, { move_cursor = true, duration = 100 }) end,
        ["zt"]    = function() neoscroll.zt({ half_win_duration = 250 }) end,
        ["zz"]    = function() neoscroll.zz({ half_win_duration = 250 }) end,
        ["zb"]    = function() neoscroll.zb({ half_win_duration = 250 }) end,
      }
      local modes = { 'n', 'v', 'x' }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end
  },
}
