return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
      { "<leader>gV", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
    },
    config = function()
      require("diffview").setup()

      -- Auto-refresh diffview every 2 seconds when it's open
      local timer = vim.uv.new_timer()
      timer:start(
        2000,
        2000,
        vim.schedule_wrap(function()
          vim.cmd("checktime")
          pcall(require("diffview.actions").refresh_files)
        end)
      )
    end,
  },
}
