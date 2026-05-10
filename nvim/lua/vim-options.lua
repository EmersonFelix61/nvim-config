-- colorscheme
-- vim.cmd.colorscheme("tokyonight-moon")

-- numbers colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "yellow", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "yellow", bold = false })

-- comment colors
vim.api.nvim_set_hl(0, "Comment", { fg = "gray" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })

-- Make line numbers default
vim.opt.number = true
--vim.opt.relativenumber = true

-- Norminette 42 School options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]

-- Clear highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode (Normal Neovim Terminal)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Split navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Plugin Keymaps ]]

-- [Spectre]
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })

-- [ LSP & Diagnostics ]
vim.keymap.set('n', '<leader>lt', ':lua vim.diagnostic.config({virtual_text=true})<CR>', { noremap = true, silent = true, desc = "LSP: Show Virtual Text" })
vim.keymap.set('n', '<leader>lf', ':lua vim.diagnostic.config({virtual_text=false})<CR>', { noremap = true, silent = true, desc = "LSP: Hide Virtual Text" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- [CopilotChat]
vim.g.copilot_no_tab_map = true
vim.keymap.set('n', '<leader>cp', ':CopilotChatOpen<CR>', { noremap = true, silent = true, desc = "Toggle [C]o[P]ilot Chat" })
vim.keymap.set('i', '<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })

-- [NvimTree]
vim.keymap.set('n', '<leader>c', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle NvimTree" })

-- [ToggleTerm]
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { noremap = true, silent = true, desc = "Toggle Terminal" })
-- Corrigido: Para fechar estando dentro do terminal, agora usa o mesmo comando de toggle
vim.keymap.set("t", "<C-t><C-t>", [[<C-\><C-n>:ToggleTerm<CR>]], { noremap = true, silent = true, desc = "Fechar ToggleTerm" })

-- [Which-key]
vim.keymap.set("n", "<leader>k", function()
  require("which-key").show(vim.g.mapleader, { mode = "n" })
end, { desc = "Mostrar Atalhos <leader>" })

vim.keymap.set("n", "<leader>gk", function()
  require("which-key").show("g")
end, { desc = "Mostrar atalhos do g"})

vim.keymap.set("n", "<leader>gz", function()
  require("which-key").show("z")
end, { desc = "Mostrar atalhos de z" })
