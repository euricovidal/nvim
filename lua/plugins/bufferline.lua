return { -- https://github.com/akinsho/bufferline.nvim
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("bufferline").setup()

    -- Navigate buffer next/prev
    vim.keymap.set("n", "<C-h>", ":BufferLineCyclePrev<CR>")
    vim.keymap.set("n", "<C-l>", ":BufferLineCycleNext<CR>")
    -- vim.keymap.set("n", "<C-Left>", ":bp<CR>")
    -- vim.keymap.set("n", "<C-Right>", ":bn<CR>")

    -- Buffer remove
    vim.keymap.set("n", "<leader>bd", ":bd<CR>")
    -- Toggle between two files in buffer
    vim.keymap.set("n", "<leader>l", ":e#<CR>")
  end
}
-- { -- other option buffer line/tabs
--   "romgrk/barbar.nvim", version = "^1.0.0",
--   dependencies = { "nvim-tree/nvim-web-devicons" }
-- },
