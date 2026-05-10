return {
	"MrSloth-dev/42-NorminetteNvim",
	dependencies = { "nvim-lua/plenary.nvim" , "echasnovski/mini.icons"},
	config = function()
		require("norminette").setup({
			norm_keybind = "<leader>n", -- keybind to enable/disable norminette warnings
			size_keybind = "<leader>ns",-- keybind to enable/disable total function lines
			diagnost_color = "#00ff00",
			show_size = true,
		})
	end,
}
