return {
  {
    'folke/drop.nvim',
    config = function()
      require('drop').setup {
        theme = 'pirate',
        max = 100,
        interval = 75,
      }
    end,
  },
}
