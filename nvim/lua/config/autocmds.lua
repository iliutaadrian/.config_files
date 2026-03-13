-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Make vertical split separator visible
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#565f89", bold = true })
  end,
})
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#565f89", bold = true })

-- Conceal values in env files (show only key names, last 3 chars visible)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", ".env.*" },
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local ns = vim.api.nvim_create_namespace("env_conceal")
    local visible_tail = 3
    local concealed = true

    local function apply_conceal()
      vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
      if not concealed then return end
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      for i, line in ipairs(lines) do
        local eq_pos = line:find("=")
        if eq_pos and not line:match("^%s*#") then
          local value = line:sub(eq_pos + 1)
          local val_len = #value
          if val_len > visible_tail then
            local hide_len = val_len - visible_tail
            local stars = string.rep("*", hide_len)
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, eq_pos, {
              virt_text = { { stars, "Comment" } },
              virt_text_pos = "overlay",
            })
          end
        end
      end
    end

    apply_conceal()

    vim.api.nvim_buf_attach(buf, false, {
      on_lines = function()
        if concealed then
          vim.schedule(apply_conceal)
        end
      end,
    })

    vim.keymap.set("n", "<leader>ue", function()
      concealed = not concealed
      apply_conceal()
    end, { buffer = true, desc = "Toggle .env values" })
  end,
})

-- Auto-reload files and refresh diffview when Neovim gains focus
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
    pcall(require("diffview.actions").refresh_files)
  end,
})
