return {
  {
    'folke/drop.nvim',
    config = function()
      require('drop').setup {
        theme = 'duck',
        max = 30,
        interval = 75,
      }
    end,
  },
}
