vim.keymap.set('n', '<leader>c', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>k", function()
  require("which-key").show(vim.g.mapleader, { mode = "n" })
end, { desc = "Mostrar Atalhos <leader>" })

vim.keymap.set("n", "<leader>gk", function()
  require("which-key").show("g")
end, { desc = "Mostrar atalhos do g"})

vim.keymap.set("n", "<leader>gz", function()
  require("which-key").show("z")
end, { desc = "Mostrar atalhos de z" })

vim.keymap.set("t", "<C-t><C-t><C-t>", [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true, desc = "Fechar ToggleTerm" })
