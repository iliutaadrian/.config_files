return {
  {
    "folke/snacks.nvim",
    opts = {
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
        sources = {
          files = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".devenv", "node_modules", ".direnv", ".idea", ".*cache.*", "*cache*", ".bundle", ".code-annotations", ".local_data" },
          },
          grep = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".devenv", "node_modules", ".direnv", ".idea", ".*cache.*", "*cache*", ".bundle", ".code-annotations", ".local_data" },
          },
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { ".git", ".devenv", "node_modules", ".direnv", ".idea", ".*cache.*", "*cache*", ".bundle", ".code-annotations", ".local_data" },
          },
        },
      },
    },
  },
}
