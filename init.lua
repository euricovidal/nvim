-- Author: Eurico Vidal <euricovidal@gmail.com>
-- Source: https://github.com/euricovidal/dotvim.git
-- CreatedAt: 2023-03-25 16:30
-- UpdatedAt: 2023-03-26 03:09

-- Lazy - Package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Vim custom options
vim.g.mapleader = ","           -- change the <leader> to comma(,)
vim.keymap.set('n', ';', ':')   -- don't need to press the shift key :

vim.o.number = true       -- show line numbers
vim.o.ruler = true        -- hightline the number of current line
vim.o.cursorcolumn = true -- highlight the current column
vim.o.cursorline = true   -- highlight the current line
vim.o.termguicolors = true

-- Lazy load plugins
require("lazy").setup("plugins")

-- Set fold method
vim.cmd("set foldenable")
vim.cmd("set foldlevelstart=3")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")

-- Force he soft of TAB
vim.o.expandtab = true
vim.o.softtabstop = 0
vim.o.shiftwidth = 2

-- clear search
vim.keymap.set("n", "<leader>/", ":nohl<CR>")

-- CTAGS refresh tags
vim.keymap.set(
  "n",
  "<leader>rt",
  ":!ctags --extra=+f --exclude=.git --exclude=log --exclude=node_modules --exclude=db --exclude=tmp -R *<CR>"
)
