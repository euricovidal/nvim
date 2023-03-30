return { -- Git status/blame inline
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
}
