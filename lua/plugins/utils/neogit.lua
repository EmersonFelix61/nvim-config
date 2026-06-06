return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    integrations = {
      diffview = true,
      telescope = true,
    },
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Git: abrir Neogit' },
  },
}
