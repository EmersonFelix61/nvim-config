return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    current_line_blame = false,
    signs = {
      add = { text = '┃' },
      change = { text = '┃' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          desc = desc,
        })
      end

      map('n', ']h', function()
        gs.nav_hunk 'next'
      end, 'Git: próximo hunk')

      map('n', '[h', function()
        gs.nav_hunk 'prev'
      end, 'Git: hunk anterior')

      map('n', '<leader>gp', gs.preview_hunk, 'Git: preview hunk')
      map('n', '<leader>gs', gs.stage_hunk, 'Git: stage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Git: reset hunk')
      map('n', '<leader>gb', function()
        gs.blame_line { full = true }
      end, 'Git: blame da linha')

      map('n', '<leader>gB', gs.toggle_current_line_blame, 'Git: toggle blame inline')
      map('n', '<leader>gw', gs.toggle_word_diff, 'Git: toggle word diff')
      map('n', '<leader>gq', function()
        gs.setqflist 'all'
      end, 'Git: listar hunks')
    end,
  },
}
