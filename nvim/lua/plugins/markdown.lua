-- Markdown preview via markdown-preview.nvim (browser), tuned for hot-reload.
--   <leader>cp  toggle the browser preview (LazyVim default keymap)
return {
  -- Browser preview, tuned to refresh live as you type in nvim.
  {
    "iamcco/markdown-preview.nvim",
    init = function()
      vim.g.mkdp_refresh_slow = 0 -- refresh on every change, not just on save
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_combine_preview = 1
      vim.g.mkdp_combine_preview_auto_refresh = 1
    end,
  },

  -- In-buffer renderer: pretty headings, tables, code blocks, checkboxes — drawn live in nvim.
  --   <leader>um  toggle rendering on/off (added below)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    opts = {
      -- Render in normal/command mode; insert mode shows raw text for editing.
      render_modes = { "n", "c", "t" },
      -- Keep the cursor line rendered too (raw reveal made tables fall apart while moving around).
      anti_conceal = { enabled = true },
      heading = { sign = false, width = "block", left_pad = 0, right_pad = 2 },
      code = { sign = false, width = "block", right_pad = 1, language_pad = 1 },
      bullet = { right_pad = 1 },
      checkbox = { enabled = true },
      -- Tables are owned by markdown-table-wrap.nvim below (wraps long cell content).
      pipe_table = { enabled = false },
    },
    keys = {
      -- One toggle for the whole rendered view: markdown rendering + wrapped-table preview.
      {
        "<leader>um",
        function()
          vim.cmd("RenderMarkdown toggle")
          local buf = vim.api.nvim_get_current_buf()
          if require("render-markdown.state").enabled then
            vim.cmd("MarkdownTableEnableAutoPreview")
            vim.cmd("MarkdownTableRefresh")
            -- Reading view: wrap on, diagnostics off (remember prior state).
            vim.b[buf].um_prev_wrap = vim.wo.wrap
            vim.wo.wrap = true
            vim.diagnostic.enable(false, { bufnr = buf })
          else
            vim.cmd("MarkdownTableDisableAutoPreview")
            vim.cmd("MarkdownTableClosePreview")
            -- Restore edit view: prior wrap, diagnostics back on.
            if vim.b[buf].um_prev_wrap ~= nil then
              vim.wo.wrap = vim.b[buf].um_prev_wrap
            end
            vim.diagnostic.enable(true, { bufnr = buf })
          end
        end,
        desc = "Toggle markdown render",
      },
    },
  },

  -- Table renderer: display-only inline tables with wrapped cell content.
  -- Auto-renders in markdown buffers; source is never modified.
  {
    "ice345/markdown-table-wrap.nvim",
    ft = "markdown",
    opts = {
      inline_disable_wrap = false, -- keep window wrap on; don't force nowrap for table preview
    },
  },
}
