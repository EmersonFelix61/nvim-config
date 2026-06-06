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
    { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Git: abrir diff do projeto' },
    { '<leader>gD', '<cmd>DiffviewClose<CR>', desc = 'Git: fechar diff' },
    { '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', desc = 'Git: histórico do arquivo' },
    { '<leader>gH', '<cmd>DiffviewFileHistory<CR>', desc = 'Git: histórico do projeto' },
  },
}
