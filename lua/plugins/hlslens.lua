return { -- Search counter
  "kevinhwang91/nvim-hlslens", -- https://github.com/kevinhwang91/nvim-hlslens
  config = function()
    require("hlslens").setup()
    require("scrollbar.handlers.search").setup()
  end
}
