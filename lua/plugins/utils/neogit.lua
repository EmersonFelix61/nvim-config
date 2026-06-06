local i18n = require 'config.i18n'

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
    { '<leader>gg', '<cmd>Neogit<CR>', desc = i18n.t 'git.open_neogit' },
  },
}
