return {
  {
    'folke/tokyonight.nvim', -- ou catppuccin
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      styles = {
        comments = { italic = false },
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
}
