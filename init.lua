-- NOTE: Run `:checkhealth` to check if your system is set-up properly
-- Not every warning is a 'must-fix' in `:checkhealth`

require 'config.options'

local i18n = require 'config.i18n'
i18n.setup_commands()

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Erro ao clonar lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Basic utility plugins
  { import = 'plugins.utils.autopairs' },
  { import = 'plugins.utils.toggleterm' },
  { import = 'plugins.utils.gitsigns' },
  { import = 'plugins.utils.indent_line' },
  { import = 'plugins.utils.mini' },
  { import = 'plugins.utils.neo-tree' },
  { import = 'plugins.utils.nvim-treesitter' },
  { import = 'plugins.utils.telescope' },
  { import = 'plugins.utils.todo-comments' },
  { import = 'plugins.utils.which-key' },
  { import = 'plugins.utils.spectre' },
  { import = 'plugins.utils.diffview' },
  { import = 'plugins.utils.neogit' },

  -- 42 School related plugins
  { import = 'plugins.42.norminette' },
  { import = 'plugins.42.flake8' },
  { import = 'plugins.42.header' },

  -- Theme-related plugins
  { import = 'plugins.themes.tokyonight' },
  { import = 'plugins.themes.switcheroo' },
  { import = 'plugins.themes.themery' },
  { import = 'plugins.themes.catppuccin' },
  { import = 'plugins.themes.available' },

  -- Viadagens
  { import = 'plugins.fun.barbar' },
  { import = 'plugins.fun.cellular' },
  { import = 'plugins.fun.drop' },
  { import = 'plugins.fun.noice' },

  -- Dashboard plugins
  { import = 'plugins.dashboard.snacks' },
  { import = 'plugins.dashboard.persistence' },

  -- LSP-related plugins
  { import = 'plugins.lsp.lazydev' },
  { import = 'plugins.lsp.lspconfig' },
  { import = 'plugins.lsp.completion' },
  { import = 'plugins.lsp.formatting' },

  -- Debugging
  { import = 'plugins.debug.dap' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require 'config.highlights'
require 'config.autocmds'
require 'config.keymaps'
