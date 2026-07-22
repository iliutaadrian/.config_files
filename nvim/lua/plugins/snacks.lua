return {
  {
    "folke/snacks.nvim",
    opts = {
      image = {
        -- Off by default; gated behind <leader>um (see markdown.lua).
        enabled = true,
        doc = {
          inline = false, -- render image inline in buffer (Ghostty/kitty protocol)
          float = true,
        },
      },
      dashboard = {
        preset = {
          header = [[
⢀⣤⣤⠤⢶⣶⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠸⡟⢿⣦⣘⠛⠋⡑⢦⠒⣖⢿⠟⠒⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠙⡍⢸⠟⠀⣧⠤⠭⣄⠀⣏⣯⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⢀⣤⠶⢚⣿⡿⣫⠤⠖⠃⠀⠀⢸⠀⠀⠀⠙⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠘⠇⠰⣯⠭⠊⠁⠀⠀⠀⠀⣠⠎⡤⠤⣮⣬⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢀⠴⠋⠀⠀⠰⢜⣄⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⡴⠊⠁⠀⡖⡒⡄⠀⡰⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⡴⠉⠀⠀⠀⢌⠳⣩⠜⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⡞⠀⠀⠀⣀⡀⢈⠟⠁⠀⠀⠀⠀⣠⠔⠋⠻⡍⣏⣉⠦⡄⠀⠀⠀⠀⠀⠀
⠀⠀⢠⡇⠀⢀⣼⡵⣻⠃⠀⠀⠀⠀⢀⡼⡥⡃⠀⠀⠧⠦⠤⠊⠙⡆⠀⠀⣀⠀⠀
⠀⠀⢸⡄⠀⠈⠚⠓⡿⣆⠀⠀⠀⣠⠮⠕⠒⣚⠐⠋⠙⠳⡄⢰⣲⠇⠀⠀⠙⣎⢦
⠀⠀⠀⣇⠀⠀⠀⠀⠃⢯⢫⢲⢹⠇⠀⠀⣰⠁⠀⠀⠀⠀⡗⠥⡿⠀⠀⠀⠀⣾⣼
⠀⠀⠀⠘⢦⡀⠀⠀⠀⠸⠚⠲⠁⠀⠀⡰⠃⠀⠀⠀⠀⠀⢷⠀⠿⢦⣀⢠⡖⠁⡼
⠀⠀⠀⠀⠀⠙⠒⠤⠤⣄⣀⣀⡤⠄⠊⠀⠀⠀⠀⠀⠀⠀⠀⠑⠠⢼⣿⡭⠄⠊⠀]],
        },
      },
      picker = {
        hidden = true, -- include hidden files in all pickers
        actions = {
          reveal_in_finder = function(picker)
            local item = picker:current()
            if item and item.file then
              vim.fn.jobstart({ "open", "-R", vim.fn.fnamemodify(item.file, ":p") }, { detach = true })
            end
          end,
        },
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = {
              ".git",
              ".devenv",
              "node_modules",
              ".direnv",
              ".idea",
              ".*cache.*",
              "*cache*",
              ".bundle",
              ".code-annotations",
              ".local_data",
            },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = {
              ".git",
              ".devenv",
              "node_modules",
              ".direnv",
              ".idea",
              ".*cache.*",
              "*cache*",
              ".bundle",
              ".code-annotations",
              ".local_data",
            },
          },
          explorer = {
            hidden = true,
            ignored = true,
            exclude = {
              ".git",
              ".devenv",
              "node_modules",
              ".direnv",
              ".idea",
              ".*cache.*",
              "*cache*",
              ".bundle",
              ".code-annotations",
              ".local_data",
            },
            win = {
              list = {
                keys = {
                  ["O"] = "reveal_in_finder",
                },
              },
            },
          },
        },
      },
    },
  },
}
