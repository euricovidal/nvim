return { -- Telescope (like CTRL+P, FZF)
  "nvim-telescope/telescope.nvim", tag = "0.1.1", -- https://github.com/nvim-telescope/telescope.nvim
  dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("telescope").setup({
      defaults = {
        borderchars = { "─", "|", "─", "|", "╭", "╮", "╯", "╰" },
        layout_config = {
          prompt_position = "bottom",
        }
      },
      -- change to vertical layout to all the files path
      pickers = {
        find_files = {
          layout_strategy = "vertical",
          layout_config = { width = 0.8, height = 0.8 },
        },
        grep_string = {
          layout_strategy = "vertical",
          layout_config = { width = 0.8, height = 0.8 },
        },
        live_grep = {
          layout_strategy = "vertical",
          layout_config = { width = 0.8, height = 0.8 },
        },
        oldfiles = {
          layout_strategy = "vertical",
          layout_config = { width = 0.8, height = 0.8 },
        },
      }
    })

    -- Enable to wrap the code on preview pane
    -- vim.cmd("autocmd User TelescopePreviewerLoaded setlocal wrap")

    vim.keymap.set('n', '<leader>p', ':Telescope<CR>', {})
    vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
    -- vim.keymap.set('n', '<leader>ff', ":Telescope find_files theme=ivy<CR>", {})
  end
}
