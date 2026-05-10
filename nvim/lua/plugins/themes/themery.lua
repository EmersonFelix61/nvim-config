return {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
	themes = {
	  "tokyonight",
	  "kanagawa",
	  "oh-lucy",
	  "cyberdream",
	  "one_monokai",
	  "catppuccin-frappe",
	  "rose-pine",
	  "fluoromachine",
},
      })
    end
  }
