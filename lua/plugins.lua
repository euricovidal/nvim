return {
  { "wakatime/vim-wakatime" },
  { "rrethy/vim-illuminate" },
  { "tpope/vim-rails" },
  { -- Theme monokai
    "crusoexia/vim-monokai",
    -- other option "cpea2506/one_monokai.nvim",
    config = function()
      vim.cmd.colorscheme('monokai')
    end
  },
  { -- Telescope (like CTRL+P, FZF)
    "nvim-telescope/telescope.nvim", tag = "0.1.1",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("telescope").setup({
        defaults = {
          borderchars = { "─", "|", "─", "|", "╭", "╮", "╯", "╰" },
          layout_config = {
            vertical = { width = 0.5 }
          }
        }
      })

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>p', ':Telescope<CR>', {})
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    -- :Lazy build telescope-fzf-native.nvim
    "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = false,
    config = function()
      require("telescope").load_extension("fzf")
    end
  },
  { -- Files Tree
    "nvim-neo-tree/neo-tree.nvim", branch = "v2.x",
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      local nvim_lsp = require('lspconfig')

      local on_attach = function(client, bufnr)
        -- require('completion').on_attach()

        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local opts = { noremap=true, silent=true }
        -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
        -- buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
      end

      -- local servers = {'pyright', 'gopls', 'rust_analyzer', 'solargraph'}
      local servers = {'solargraph'}
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
          on_attach = on_attach,
        }
      end

      -- require('nvim-treesitter.configs').setup({
      --   highlight = {
      --     enable = true
      --   }
      -- })
    end
  },
  {
    "glepnir/lspsaga.nvim",
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
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          -- theme = 'molokai', -- 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          -- disabled_filetypes = {
          --   statusline = {},
          --   winbar = {},
          -- },
          -- ignore_focus = {},
          -- always_divide_middle = true,
          -- globalstatus = false,
          -- refresh = {
          --   statusline = 1000,
          --   tabline = 1000,
          --   winbar = 1000,
          -- }
        },
        -- sections = {
        --   lualine_a = {'mode'},
        --   lualine_b = {'branch', 'diff', 'diagnostics'},
        --   lualine_c = {'filename'},
        --   lualine_x = {'encoding', 'fileformat', 'filetype'},
        --   lualine_y = {'progress'},
        --   lualine_z = {'location'}
        -- },
        -- inactive_sections = {
        --   lualine_a = {},
        --   lualine_b = {},
        --   lualine_c = {'filename'},
        --   lualine_x = {'location'},
        --   lualine_y = {},
        --   lualine_z = {}
        -- },
        -- tabline = {},
        -- winbar = {},
        -- inactive_winbar = {},
        -- extensions = {}
      })
    end
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup()

      -- Navigate buffer next/prev
      vim.keymap.set("n", "<C-Left>", ':BufferLineCyclePrev<CR>')
      vim.keymap.set("n", "<C-Right>", ':BufferLineCycleNext<CR>')

      -- Buffer remove
      vim.keymap.set("n", "<leader>bd", ':bd<CR>')
    end
  },
  -- { -- other option buffer line/tabs
  --   "romgrk/barbar.nvim", version = "^1.0.0",
  --   dependencies = { "nvim-tree/nvim-web-devicons" }
  -- },
  {
    "echasnovski/mini.nvim", version = '*',
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
        -- Module mappings. Use `''` (empty string) to disable one.
        -- mappings = {
        --   -- Textobjects
        --   object_scope = 'ii',
        --   object_scope_with_border = 'ai',

        --   -- Motions (jump to respective border line; if not present - body line)
        --   goto_top = '[i',
        --   goto_bottom = ']i',
        -- },

        -- Which character to use for drawing scope indicator
        symbol = '¦'
      })
    end
  },
  { -- Remove empty spaces
    "mcauley-penney/tidy.nvim",
    config = function()
      require("tidy").setup()
    end
  },
  {
    "gbprod/yanky.nvim",
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
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      require("scrollbar.handlers.search").setup()
    end
  },
  { -- Scrollbar
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  },
  { -- Git status/blame inline
    "lewis6991/gitsigns.nvim",
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
    "dense-analysis/ale",
    config = function()
      vim.g.ale_floating_window_border = { '|', '─', '╭', '╮', '╯', '╰', '|', '─' }
      require("scrollbar.handlers.ale").setup()
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup()

      require("telescope").load_extension("notify")
    end
  },
  -- { -- quebrou a descrição dos autocomplete (modal)
  --   "folke/noice.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  --   config = function()
  --     require("noice").setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true, -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     })
  --   end
  -- }
  { -- Trouble
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})
    end
  }
}
