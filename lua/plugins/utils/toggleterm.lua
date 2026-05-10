return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-t>]], -- Abre e fecha com Ctrl + t
      hide_numbers = true,
      shade_terminals = true,
      direction = 'horizontal', -- Abre na parte de baixo
      close_on_exit = true,
    })
  end
}
