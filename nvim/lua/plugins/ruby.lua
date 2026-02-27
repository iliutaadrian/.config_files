-- Ruby LSP configuration for Nix-managed golfgenius project
-- Mason's rubocop wrapper is broken (expects RVM's ruby_executable_hooks)
-- so we tell both solargraph and rubocop to use system binaries from PATH
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        solargraph = {
          mason = false, -- use system solargraph (installed via Nix/gem)
          cmd = { "solargraph", "stdio" },
          settings = {
            solargraph = {
              diagnostics = true,
              formatting = false, -- let rubocop handle formatting via conform
            },
          },
        },
        rubocop = {
          mason = false, -- use Nix-provided rubocop, not Mason's broken wrapper
          cmd = { "rubocop", "--lsp" },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        rubocop = {
          command = "rubocop",
        },
      },
    },
  },
}
