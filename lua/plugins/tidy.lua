return { -- Remove empty spaces
  "mcauley-penney/tidy.nvim", -- https://github.com/mcauley-penney/tidy.nvim
  config = function()
    require("tidy").setup()
  end
}
