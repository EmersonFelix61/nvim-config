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
      local i18n = require 'config.i18n'
      local gs = package.loaded.gitsigns

      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, {
          buffer = bufnr,
          desc = desc,
        })
      end

      map('n', ']h', function()
        gs.nav_hunk 'next'
      end, i18n.t 'git.next_hunk')

      map('n', '[h', function()
        gs.nav_hunk 'prev'
      end, i18n.t 'git.prev_hunk')

      map('n', '<leader>gp', gs.preview_hunk, i18n.t 'git.preview_hunk')
      map('n', '<leader>gs', gs.stage_hunk, i18n.t 'git.stage_hunk')
      map('n', '<leader>gr', gs.reset_hunk, i18n.t 'git.reset_hunk')
      map('n', '<leader>gb', function()
        gs.blame_line { full = true }
      end, i18n.t 'git.blame_line')

      map('n', '<leader>gB', gs.toggle_current_line_blame, i18n.t 'git.inline_blame')
      map('n', '<leader>gw', gs.toggle_word_diff, i18n.t 'git.word_diff')
      map('n', '<leader>gq', function()
        gs.setqflist 'all'
      end, i18n.t 'git.list_hunks')
    end,
  },
}
