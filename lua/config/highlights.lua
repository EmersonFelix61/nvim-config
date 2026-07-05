-- Number colors
vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = 'yellow', bold = false })
vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = 'yellow', bold = false })

-- Comment colors
vim.api.nvim_set_hl(0, 'Comment', { fg = 'gray' })
vim.api.nvim_set_hl(0, '@comment', { link = 'Comment' })
