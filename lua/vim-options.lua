-- colorscheme
-- vim.cmd.colorscheme("tokyonight-moon")

local i18n = require 'config.i18n'

-- numbers colors
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'yellow', bold = false })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'yellow', bold = false })

-- comment colors
vim.api.nvim_set_hl(0, 'Comment', { fg = 'gray' })
vim.api.nvim_set_hl(0, '@comment', { link = 'Comment' })

-- Make line numbers default
vim.opt.number = true
--vim.opt.relativenumber = true

-- Norminette 42 School options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.mouse = 'a'
vim.opt.showmode = false

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]

-- Clear highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Easier escape from insert/visual mode
vim.keymap.set({ 'i', 'v', 's' }, 'jk', '<Esc>', { desc = i18n.t 'map.escape_normal' })

-- Exit terminal mode (Normal Neovim Terminal)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = i18n.t 'map.escape_terminal' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = i18n.t 'map.focus_left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = i18n.t 'map.focus_right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = i18n.t 'map.focus_down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = i18n.t 'map.focus_up' })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = i18n.t 'map.highlight_yank',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Plugin Keymaps ]]

-- [Spectre]
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = i18n.t 'map.spectre_toggle' })
vim.keymap.set('n', '<leader>sW', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = i18n.t 'map.spectre_current_word' })
vim.keymap.set('v', '<leader>sW', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = i18n.t 'map.spectre_selection' })
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = i18n.t 'map.spectre_current_file' })

-- [ LSP & Diagnostics ]
vim.keymap.set('n', '<leader>le', function()
  vim.diagnostic.open_float(nil, {
    focusable = true,
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  })
end, {
  noremap = true,
  silent = true,
  desc = i18n.t 'diagnostics.full_error',
})
vim.keymap.set(
  'n',
  '<leader>lt',
  ':lua vim.diagnostic.config({virtual_text=true})<CR>',
  { noremap = true, silent = true, desc = i18n.t 'diagnostics.show_virtual_text' }
)
vim.keymap.set(
  'n',
  '<leader>lf',
  ':lua vim.diagnostic.config({virtual_text=false})<CR>',
  { noremap = true, silent = true, desc = i18n.t 'diagnostics.hide_virtual_text' }
)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = i18n.t 'diagnostics.quickfix' })

-- [Neo-tree]
vim.keymap.set('n', '<leader>c', '<cmd>Neotree toggle reveal<CR>', { noremap = true, silent = true, desc = i18n.t 'map.neotree_toggle' })

-- [ToggleTerm]
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true, desc = i18n.t 'map.toggle_terminal' })
-- Corrigido: Para fechar estando dentro do terminal, agora usa o mesmo comando de toggle
vim.keymap.set('t', '<C-t><C-t>', [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true, desc = i18n.t 'map.toggle_terminal' })

-- [Which-key]
vim.keymap.set('n', '<leader>k', function()
  require('which-key').show { keys = vim.g.mapleader, mode = 'n' }
end, { desc = i18n.t 'map.which_key_leader' })

vim.keymap.set('n', '<leader>gk', function()
  require('which-key').show { keys = 'g', mode = 'n' }
end, { desc = i18n.t 'map.which_key_g' })

vim.keymap.set('n', '<leader>gz', function()
  require('which-key').show { keys = 'z', mode = 'n' }
end, { desc = i18n.t 'map.which_key_z' })

vim.keymap.set('n', '<leader>li', '<cmd>Idioma toggle<CR>', { desc = i18n.t 'lang.toggle' })
