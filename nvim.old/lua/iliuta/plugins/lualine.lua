local function get_attached_clients()
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return "LSP Inactive"
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "copilot" and client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.

  -- Add sources (from null-ls)
  -- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
  local null_ls_s, null_ls = pcall(require, "nvim-lint")
  if null_ls_s then
    local sources = null_ls.get_sources()
    for _, source in ipairs(sources) do
      if source._validated then
        for ft_name, ft_active in pairs(source.filetypes) do
          if ft_name == buf_ft and ft_active then
            table.insert(buf_client_names, source.name)
          end
        end
      end
    end
  end

  -- Add linters (from nvim-lint)
  local lint_s, lint = pcall(require, "lint")
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == "table" then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == "string" then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  -- Add formatters (from formatter.nvim)
  local formatter_s, _ = pcall(require, "stevearc/conform.nvim")
  if formatter_s then
    local formatter_util = require("stevearc/conform.nvim")
    for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end

  -- This needs to be a string only table so we can use concat below
  local unique_client_names = {}
  for _, client_name_target in ipairs(buf_client_names) do
    local is_duplicate = false
    for _, client_name_compare in ipairs(unique_client_names) do
      if client_name_target == client_name_compare then
        is_duplicate = true
      end
    end
    if not is_duplicate then
      table.insert(unique_client_names, client_name_target)
    end
  end

  local client_names_str = table.concat(unique_client_names, ", ")
  local language_servers = string.format("[%s]", client_names_str)

  return language_servers
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    local attached_clients = {
      get_attached_clients,
      color = {
        gui = "bold",
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_x = {
          "searchcount",
          "encoding",
          "fileformat",
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          attached_clients,
          "filetype",
        },

        --   lualine_x = {
        --     {
        --       attached_clients,
        --     },
        --     -- {
        --     --   lazy_status.updates,
        --     --   cond = lazy_status.has_updates,
        --     --   color = { fg = "#ff9e64" },
        --     -- },
        --     { "searchcount" },
        --     { "encoding" },
        --     { "fileformat" },
        --     { "filetype" },
        --   },
      },
    })
  end,
}
