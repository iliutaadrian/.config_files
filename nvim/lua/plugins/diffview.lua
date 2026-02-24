return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diff View" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "File History" },
    },
  },
}
