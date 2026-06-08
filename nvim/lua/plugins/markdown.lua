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

  -- Disable the in-buffer renderer that ships with the LazyVim markdown extra.
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
}
