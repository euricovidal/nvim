-- Author: Eurico Vidal <euricovidal@gmail.com>
-- Source: https://github.com/euricovidal/dotvim.git
-- CreatedAt: 2023-03-25 16:30

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

-- Set undo/swap/backup dir all inside the nvim tmp path
vim.cmd("set undofile")
vim.cmd("set backupdir=~/.config/nvim/tmp/backup/")
vim.cmd("set undodir=~/.config/nvim/tmp/undo/")
vim.cmd("set directory=~/.config/nvim/tmp/swap/")
os.execute("mkdir -p ./tmp/backup/")
os.execute("mkdir -p ./tmp/undo/")
os.execute("mkdir -p ./tmp/swap/")

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

-- write a debugger 🤘
vim.keymap.set(
  "n",
  "<leader>d",
  function()
    local debug = ""
    if vim.bo.filetype == "ruby" then
      debug = "require 'pry-nav'; binding.pry"
    elseif vim.bo.filetype == "javascript" then
      debug = "debugger"
    end

    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    vim.api.nvim_buf_set_lines(
      vim.api.nvim_get_current_buf(), vim.fn.line('.'), vim.fn.line('.'), false, { debug }
    )
    -- move the curor to the new line
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1] + 1, 0 })
    vim.api.nvim_command('w')
  end
)

-- Find merge conflict markers
vim.keymap.set("n", "<leader>cf", "<ESC>/\v^[<=>\|]{7}( .*\|$)<CR>")
