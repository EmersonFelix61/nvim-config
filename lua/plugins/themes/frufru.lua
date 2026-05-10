return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- Ou "latte" se quiser um rosa claro de doer o olho
        transparent_background = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = true,
          -- Isso aqui vai deixar tudo muito mais detalhado e colorido
        },
        color_overrides = {
          frappe = {
            base = "#2a222d", -- Um roxo bem escuro pro fundo
            mantle = "#251e27",
            crust = "#1e1920",
          },
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },
  -- Plugin para notificações bonitinhas e rosas
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        render = "minimal",
        stages = "fade",
      })
    end
  }
}
