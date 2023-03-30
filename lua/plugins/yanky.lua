return { -- https://github.com/gbprod/yanky.nvim
  "gbprod/yanky.nvim",
  config = function()
    require("yanky").setup()

    require("telescope").load_extension("yank_history")

    vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
    vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
    vim.keymap.set("n", "<C-n>", "<Plug>(YankyCycleForward)")
    vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleBackward)")
  end
}
