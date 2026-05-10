return {
  {
    "folke/tokyonight.nvim", -- ou catppuccin
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
