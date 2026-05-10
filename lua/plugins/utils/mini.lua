return { -- Collection of various small independent plugins/modules
	"echasnovski/mini.nvim",

	config = function()
		-- Better Around/Inside textobjects
		--
		-- Examples:
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--
		-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		-- - sd'   - [S]urround [D]elete [']quotes
		-- - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Move lines and visual selections with Alt + hjkl
		require("mini.move").setup({
			mappings = {
				-- Move visual selection
				left = "<A-h>",
				right = "<A-l>",
				down = "<A-j>",
				up = "<A-k>",

				-- Move current line
				line_left = "<A-h>",
				line_right = "<A-l>",
				line_down = "<A-j>",
				line_up = "<A-k>",
			},
		})

		-- Comments
		require("mini.comment").setup()

		-- Statusline
		local statusline = require("mini.statusline")

		statusline.setup({
			use_icons = vim.g.have_nerd_font,

			content = {
				active = function()
					local mode, mode_hl =
						statusline.section_mode({ trunc_width = 120 })

					local git =
						statusline.section_git({ trunc_width = 40 })

					local diagnostics =
						statusline.section_diagnostics({ trunc_width = 75 })

					local filename =
						statusline.section_filename({ trunc_width = 140 })

					local fileinfo =
						statusline.section_fileinfo({ trunc_width = 120 })

					local location =
						statusline.section_location({ trunc_width = 75 })

					return statusline.combine_groups({
						{
							hl = mode_hl,
							strings = { mode },
						},

						{
							hl = "MiniStatuslineDevinfo",
							strings = { git, diagnostics },
						},

						"%<",

						{
							hl = "MiniStatuslineFilename",
							strings = { filename },
						},

						"%=",

						{
							hl = "MiniStatuslineFilename",
							strings = { "" },
						},

						"%=",

						{
							hl = "MiniStatuslineFileinfo",
							strings = { fileinfo },
						},

						{
							hl = mode_hl,
							strings = { location },
						},
					})
				end,
			},
		})

		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end

		-- ... and there is more!
		-- Check out: https://github.com/echasnovski/mini.nvim
	end,
}
