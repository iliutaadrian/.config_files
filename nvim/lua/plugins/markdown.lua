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
      -- Render in normal/command mode; the line under the cursor shows raw text so editing is easy.
      render_modes = { "n", "c", "t" },
      heading = { sign = false, width = "block", left_pad = 0, right_pad = 2 },
      code = { sign = false, width = "block", right_pad = 1, language_pad = 1 },
      bullet = { right_pad = 1 },
      checkbox = { enabled = true },
    },
    keys = {
      { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle markdown render" },
    },
  },
}
