return { -- https://github.com/dense-analysis/ale
  "dense-analysis/ale",
  config = function()
    vim.g.ale_floating_window_border = { '|', '─', '╭', '╮', '╯', '╰', '|', '─' }
    require("scrollbar.handlers.ale").setup()
  end
}
