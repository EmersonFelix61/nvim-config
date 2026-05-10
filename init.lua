-- NOTE: Run `:checkhealth` to check if your system is set-up properly
-- Not every warning is a 'must-fix' in `:checkhealth`

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--  NOTE: set true if a Nerd Font is installed
vim.g.have_nerd_font = true 

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  --	Basic Utitlity Plugins:
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

  --	42 School Related Plugins:
  { import = 'plugins.42.42-norminette' },
  { import = 'plugins.42.42-header' },

  --	Theme Related Plugins:
  { import = 'plugins.themes.tokyo' },
  { import = 'plugins.themes.switcheroo' },
  { import = 'plugins.themes.themery' },
  { import = 'plugins.themes.theme-stash' },
  
  -- Novos Temas (Adicione os arquivos correspondentes na pasta plugins/themes/)
  { "rebelot/kanagawa.nvim" },
  { "Yazeed1s/oh-lucy.nvim" },
  { "scottmckendry/cyberdream.nvim" },
  { "cpea2506/one_monokai.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "folke/tokyonight.nvim" },
  { "maxmx03/fluoromachine.nvim" },

  --	Viadagens:
  {import = 'plugins.fun'},

  --	Dashboard Plugins:
  { import = 'plugins.dashboard.snacks' },
  { import = 'plugins.dashboard.persistence' },

  --	LSP Related Plugins:
  { import = 'plugins.LSP.lazydev' },
  { import = 'plugins.LSP.nvim-lspconfig' },
  { import = "plugins.LSP.nvim-cmp_autocompletion" },

  --	AI Related Plugins:
  { import = 'plugins.AI.copilot' },
  { import = 'plugins.AI.copilotChat' },
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

require 'vim-options'
