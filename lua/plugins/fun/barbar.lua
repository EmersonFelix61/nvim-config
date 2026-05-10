return {
	"romgrk/barbar.nvim",
	version = "^1.0.0",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- mostra status do git nos buffers
		"nvim-tree/nvim-web-devicons", -- ícones dos arquivos
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {
		animation = true,
		auto_hide = false,
		tabpages = true,
		clickable = true,

		insert_at_end = true,

		icons = {
			buffer_index = false,
			buffer_number = false,
			button = "",
			separator = { left = "▎", right = "" },
			modified = { button = "●" },
			pinned = { button = "", filename = true },
			alternate = { filetype = { enabled = false } },
			current = { buffer_index = true },
			inactive = { button = "×" },
			visible = { modified = { buffer_number = false } },
		},

		sidebar_filetypes = {
			["neo-tree"] = {
				event = "BufWipeout",
				text = "Neo-tree",
				align = "center",
			},
		},
	},
	keys = {
		-- Navegar entre buffers
		{ "<Tab>", "<cmd>BufferNext<CR>", desc = "Próximo buffer" },
		{ "<S-Tab>", "<cmd>BufferPrevious<CR>", desc = "Buffer anterior" },

		-- Mover buffer de posição
		{ "<leader>b.", "<cmd>BufferMoveNext<CR>", desc = "Mover buffer para direita" },
		{ "<leader>b,", "<cmd>BufferMovePrevious<CR>", desc = "Mover buffer para esquerda" },

		-- Fechar buffers
		{ "<leader>bd", "<cmd>BufferClose<CR>", desc = "Fechar buffer atual" },
		{ "<leader>bo", "<cmd>BufferCloseAllButCurrent<CR>", desc = "Fechar outros buffers" },
		{ "<leader>br", "<cmd>BufferCloseBuffersRight<CR>", desc = "Fechar buffers à direita" },
		{ "<leader>bl", "<cmd>BufferCloseBuffersLeft<CR>", desc = "Fechar buffers à esquerda" },

		-- Escolher buffer visualmente
		{ "<leader>bp", "<cmd>BufferPick<CR>", desc = "Escolher buffer" },
		{ "<leader>bc", "<cmd>BufferPickDelete<CR>", desc = "Escolher buffer para fechar" },

		-- Fixar buffer
		{ "<leader>bP", "<cmd>BufferPin<CR>", desc = "Fixar/desfixar buffer" },

		-- Ordenar buffers
		{ "<leader>bs", "<cmd>BufferOrderByDirectory<CR>", desc = "Ordenar buffers por diretório" },
		{ "<leader>be", "<cmd>BufferOrderByExtension<CR>", desc = "Ordenar buffers por extensão" },
	},
}
