return {
  { "wakatime/vim-wakatime" }, -- https://github.com/wakatime/vim-wakatime
  { "rrethy/vim-illuminate" }, -- https://github.com/RRethy/vim-illuminate
  { "tpope/vim-rails" }, -- https://github.com/tpope/vim-rails
  { -- Theme monokai
    "crusoexia/vim-monokai", -- https://github.com/crusoexia/vim-monokai
    -- other option "cpea2506/one_monokai.nvim", -- https://github.com/cpea2506/one_monokai.nvim
    config = function()
      vim.cmd.colorscheme('monokai')
    end
  },
  { -- Telescope (like CTRL+P, FZF)
    "nvim-telescope/telescope.nvim", tag = "0.1.1", -- https://github.com/nvim-telescope/telescope.nvim
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("telescope").setup({
        defaults = {
          borderchars = { "─", "|", "─", "|", "╭", "╮", "╯", "╰" },
          layout_config = {
            prompt_position = "bottom",
          }
        },
        -- change to vertical layout to all the files path
        pickers = {
          find_files = {
            layout_strategy = "vertical",
            layout_config = { width = 0.8, height = 0.8 },
          },
          grep_string = {
            layout_strategy = "vertical",
            layout_config = { width = 0.8, height = 0.8 },
          },
          live_grep = {
            layout_strategy = "vertical",
            layout_config = { width = 0.8, height = 0.8 },
          },
          oldfiles = {
            layout_strategy = "vertical",
            layout_config = { width = 0.8, height = 0.8 },
          },
        }
      })

      -- Enable to wrap the code on preview pane
      -- vim.cmd("autocmd User TelescopePreviewerLoaded setlocal wrap")

      vim.keymap.set('n', '<leader>p', ':Telescope<CR>', {})
      vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', {})
      -- vim.keymap.set('n', '<leader>ff', ":Telescope find_files theme=ivy<CR>", {})
    end
  },
  { -- Files Tree
    "nvim-neo-tree/neo-tree.nvim", branch = "v2.x", -- https://github.com/nvim-neo-tree/neo-tree.nvim
    dependencies = {
      "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim",
      {
        "s1n7ax/nvim-window-picker",
        config = function()
          require("window-picker").setup({
            autoselect_one = true,
            include_current = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', "neo-tree-popup", "notify" },

                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', "quickfix" },
              },
            },
            other_win_hl_color = '#e35e4f',
          })
        end
      }
    },
    config = function()
      require("neo-tree").setup({
        source_selector = {
          winbar = true,
          statusline = true
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
                "toggle_node",
                nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            -- ["S"] = "open_split",
            -- ["s"] = "open_vsplit",
            ["S"] = "split_with_window_picker",
            ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none" -- "none", "relative", "absolute"
              }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
      })
      vim.keymap.set('n', '<leader>ef', ':NeoTreeRevealToggle<CR>')
      vim.keymap.set('n', '<leader>e', ':NeoTreeFocusToggle<CR>')
      vim.keymap.set('n', '<leader>ew', ':NeoTreeFloatToggle<CR>')
    end
  },
  -- { -- other option - Files Tree
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("nvim-tree").setup()

  --     vim.keymap.set('n', '<leader>ef', ':NvimTreeFindFileToggle<CR>')
  --     vim.keymap.set('n', '<leader>e', require('nvim-tree.api').tree.toggle)
  --   end
  -- },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- https://github.com/neovim/nvim-lspconfig
    config = function()
      local nvim_lsp = require('lspconfig')

      for _, lsp in ipairs({'solargraph', 'solargraph-rails'}) do
        nvim_lsp[lsp].setup {
          on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
            local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

            buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
          end
        }
      end
    end
  },
  {
    "glepnir/lspsaga.nvim", -- https://github.com/glepnir/lspsaga.nvim
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    event = "BufRead",
    config = function()
      require("lspsaga").setup()

      local keymap = vim.keymap.set
      -- LSP finder - Find the symbol's definition
      -- If there is no definition, it will instead be hidden
      -- When you use an action in finder like "open vsplit",
      -- you can use <C-t> to jump back
      keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

      -- Code action
      -- keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

      -- Rename all occurrences of the hovered word for the entire file
      keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

      -- Rename all occurrences of the hovered word for the selected files
      -- keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

      -- Peek definition
      -- You can edit the file containing the definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      keymap("n", "gdm", "<cmd>Lspsaga peek_definition<CR>")

      -- Go to definition
      keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

      -- Peek type definition
      -- You can edit the file containing the type definition in the floating window
      -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
      -- It also supports tagstack
      -- Use <C-t> to jump back
      -- keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

      -- Go to type definition
      -- keymap("n","gt", "<cmd>Lspsaga goto_type_definition<CR>")

      -- -- Show line diagnostics
      -- -- You can pass argument ++unfocus to
      -- -- unfocus the show_line_diagnostics floating window
      -- keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

      -- -- Show cursor diagnostics
      -- -- Like show_line_diagnostics, it supports passing the ++unfocus argument
      -- keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

      -- -- Show buffer diagnostics
      -- keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

      -- -- Diagnostic jump
      -- -- You can use <C-o> to jump back to your previous location
      -- keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      -- keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

      -- -- Diagnostic jump with filters such as only jumping to an error
      -- keymap("n", "[E", function()
      --   require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      -- end)
      -- keymap("n", "]E", function()
      --   require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      -- end)

      -- Toggle outline
      keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

      -- Hover Doc
      -- If there is no hover doc,
      -- there will be a notification stating that
      -- there is no information available.
      -- To disable it just use ":Lspsaga hover_doc ++quiet"
      -- Pressing the key twice will enter the hover window
      -- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

      -- -- If you want to keep the hover window in the top right hand corner,
      -- -- you can pass the ++keep argument
      -- -- Note that if you use hover with ++keep, pressing this key again will
      -- -- close the hover window. If you want to jump to the hover window
      -- -- you should use the wincmd command "<C-w>w"
      -- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

      -- -- Call hierarchy
      -- keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      -- keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

      keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
    end
  },
  { -- Statusline
    "nvim-lualine/lualine.nvim", -- https://github.com/nvim-lualine/lualine.nvim
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
      })
    end
  },
  {
    "akinsho/bufferline.nvim", -- https://github.com/akinsho/bufferline.nvim
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
  },
  -- { -- other option buffer line/tabs
  --   "romgrk/barbar.nvim", version = "^1.0.0",
  --   dependencies = { "nvim-tree/nvim-web-devicons" }
  -- },
  {
    "echasnovski/mini.nvim", version = '*', -- https://github.com/echasnovski/mini.nvim
    config = function()
      require("mini.animate").setup()
      require("mini.completion").setup()
      require("mini.move").setup({
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = '<M-h>',
          right = '<M-l>',
          down = '<M-j>',
          up = '<M-k>',

          -- Move current line in Normal mode
          line_left = '<M-h>',
          line_right = '<M-l>',
          line_down = '<M-j>',
          line_up = '<M-k>',
        },
      })
      require("mini.pairs").setup()
      require("mini.surround").setup() -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-surround.md
      require("mini.comment").setup()
      require("mini.indentscope").setup({
        symbol = '¦'
      })
    end
  },
  { -- Remove empty spaces
    "mcauley-penney/tidy.nvim", -- https://github.com/mcauley-penney/tidy.nvim
    config = function()
      require("tidy").setup()
    end
  },
  {
    "gbprod/yanky.nvim", -- https://github.com/gbprod/yanky.nvim
    config = function()
      require("yanky").setup()

      require("telescope").load_extension("yank_history")

      vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set("n", "<C-n>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<C-p>", "<Plug>(YankyCycleBackward)")
    end
  },
  { -- Search counter
    "kevinhwang91/nvim-hlslens", -- https://github.com/kevinhwang91/nvim-hlslens
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
    end
  },
  { -- Scrollbar
    "petertriho/nvim-scrollbar", -- https://github.com/petertriho/nvim-scrollbar
    config = function()
      require("scrollbar").setup()
    end
  },
  { -- Git status/blame inline
    "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim
    config = function()
      require("gitsigns").setup({
        current_line_blame_opts = {
          delay = 3000, -- 3s
        },
        -- current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, {expr=true})

          -- Actions
          map('n', '<leader>hb', function() gs.blame_line{full=true} end)
          -- map('n', '<leader>tb', gs.toggle_current_line_blame)

          -- auto enable git blame
          gs.toggle_current_line_blame()
        end
      })

      require("scrollbar.handlers.gitsigns").setup()
    end
  },
  {
    "dense-analysis/ale", -- https://github.com/dense-analysis/ale
    config = function()
      vim.g.ale_floating_window_border = { '|', '─', '╭', '╮', '╯', '╰', '|', '─' }
      require("scrollbar.handlers.ale").setup()
    end
  },
  { -- Trouble
    "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
    end
  },
  { -- Basic Snippets
    "dcampos/nvim-snippy", -- https://github.com/dcampos/nvim-snippy
    dependencies = { "honza/vim-snippets" },
    config = function()
      require('snippy').setup({
        mappings = {
          is = {
            ['<Tab>'] = 'expand_or_advance',
            ['<S-Tab>'] = 'previous',
          },
          nx = {
            ['<leader>x'] = 'cut_text',
          },
        },
      })
    end
  },
  { -- splash/initial screen
    "glepnir/dashboard-nvim", -- https://github.com/glepnir/dashboard-nvim
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('dashboard').setup({
        theme = 'hyper',
        shortcut_type = 'number',
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
            {
              icon = ' ',
              icon_hl = '@variable',
              desc = 'Files',
              group = 'Label',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              desc = ' Apps',
              group = 'DiagnosticHint',
              action = 'Telescope app',
              key = 'a',
            },
            {
              desc = ' dotfiles',
              group = 'Number',
              action = 'Telescope dotfiles',
              key = 'd',
            },
            {
              desc = '✸ new',
              group = '@property',
              action = 'e new',
              key = 'n',
            },
          }
        },
      })

      -- TODO: try to put this in somewhere
      -- vim.g.startup_bookmarks = {
      --   ["V"] = '~/.config/nvim/init.lua',
      --   ["P"] = '~/.config/nvim/lua/plugins.lua',
      --   ["G"] = '~/.gitconfig',
      --   ["Z"] = '~/.zshrc',
      --   ["S"] = '~/.ssh/config',
      -- }
    end
  },
  { -- save the cursor position
    "farmergreg/vim-lastplace", -- https://github.com/farmergreg/vim-lastplace
    config = function()
      vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit"
    end
  }
}
