return { -- Theme monokai
  "crusoexia/vim-monokai", -- https://github.com/crusoexia/vim-monokai
  -- other option "cpea2506/one_monokai.nvim", -- https://github.com/cpea2506/one_monokai.nvim
  config = function()
    vim.cmd.colorscheme('monokai')
  end
}
