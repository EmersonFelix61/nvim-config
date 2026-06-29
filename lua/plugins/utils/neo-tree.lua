-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

local i18n = require 'config.i18n'

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = i18n.t 'map.neotree_reveal', silent = true },
  },
  opts = {
    filesystem = {
      window = {
        position = 'left',
        width = 33,
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
