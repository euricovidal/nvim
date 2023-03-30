return { -- splash/initial screen
  "glepnir/dashboard-nvim", -- https://github.com/glepnir/dashboard-nvim
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      shortcut_type = 'number',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            icon = ' ',
            icon_hl = '@variable',
            desc = 'Files',
            group = 'Label',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = ' Apps',
            group = 'DiagnosticHint',
            action = 'Telescope app',
            key = 'a',
          },
          {
            desc = ' dotfiles',
            group = 'Number',
            action = 'Telescope dotfiles',
            key = 'd',
          },
          {
            desc = '✸ new',
            group = '@property',
            action = 'e new',
            key = 'n',
          },
        }
      },
    })

    -- TODO: try to put this in somewhere
    -- vim.g.startup_bookmarks = {
    --   ["V"] = '~/.config/nvim/init.lua',
    --   ["P"] = '~/.config/nvim/lua/plugins.lua',
    --   ["G"] = '~/.gitconfig',
    --   ["Z"] = '~/.zshrc',
    --   ["S"] = '~/.ssh/config',
    -- }
  end
}
