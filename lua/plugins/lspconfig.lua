return { -- https://github.com/neovim/nvim-lspconfig
  "neovim/nvim-lspconfig",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local nvim_lsp = require('lspconfig')

    for _, lsp in ipairs({'solargraph'}) do
      nvim_lsp[lsp].setup {
        on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        end
      }
    end
  end
}
