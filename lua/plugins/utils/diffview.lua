local i18n = require 'config.i18n'

return {
  'sindrets/diffview.nvim',
  cmd = {
    'DiffviewOpen',
    'DiffviewFileHistory',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = i18n.t 'git.open_diff' },
    { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = i18n.t 'git.close_diff' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = i18n.t 'git.file_history' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = i18n.t 'git.project_history' },
  },
}
