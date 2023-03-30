return { -- save the cursor position
  "farmergreg/vim-lastplace", -- https://github.com/farmergreg/vim-lastplace
  config = function()
    vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
  end
}
