return { -- Highlight todo, notes, etc in comments
	"folke/todo-comments.nvim",
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = { signs = false },
}

--  PERF: fully optimised
--  HACK: this looks a bit funky
--  TODO: reminder to add something
--  NOTE: adding a note
--  FIX:  this needs fixing
--  WARNING: CARE THIS, idk 
