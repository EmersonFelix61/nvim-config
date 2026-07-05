local i18n = require 'config.i18n'

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = i18n.t 'map.highlight_yank',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
