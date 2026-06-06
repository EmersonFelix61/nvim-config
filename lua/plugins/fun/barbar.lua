local i18n = require "config.i18n"

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
		{ "<Tab>", "<cmd>BufferNext<CR>", desc = i18n.t("map.buffer_next") },
		{ "<S-Tab>", "<cmd>BufferPrevious<CR>", desc = i18n.t("map.buffer_previous") },

		-- Mover buffer de posição
		{ "<leader>b.", "<cmd>BufferMoveNext<CR>", desc = i18n.t("map.buffer_move_right") },
		{ "<leader>b,", "<cmd>BufferMovePrevious<CR>", desc = i18n.t("map.buffer_move_left") },

		-- Fechar buffers
		{ "<leader>bd", "<cmd>BufferClose<CR>", desc = i18n.t("map.buffer_close") },
		{ "<leader>bo", "<cmd>BufferCloseAllButCurrent<CR>", desc = i18n.t("map.buffer_close_others") },
		{ "<leader>br", "<cmd>BufferCloseBuffersRight<CR>", desc = i18n.t("map.buffer_close_right") },
		{ "<leader>bl", "<cmd>BufferCloseBuffersLeft<CR>", desc = i18n.t("map.buffer_close_left") },

		-- Escolher buffer visualmente
		{ "<leader>bp", "<cmd>BufferPick<CR>", desc = i18n.t("map.buffer_pick") },
		{ "<leader>bc", "<cmd>BufferPickDelete<CR>", desc = i18n.t("map.buffer_close_picker") },

		-- Fixar buffer
		{ "<leader>bP", "<cmd>BufferPin<CR>", desc = i18n.t("map.buffer_pin") },

		-- Ordenar buffers
		{ "<leader>bs", "<cmd>BufferOrderByDirectory<CR>", desc = i18n.t("map.buffer_order_directory") },
		{ "<leader>be", "<cmd>BufferOrderByExtension<CR>", desc = i18n.t("map.buffer_order_extension") },
	},
}
