return {
  {
    'folke/drop.nvim',
    config = function()
      require('drop').setup {
        theme = 'snow',
        max = 30,
        interval = 75,
      }
    end,
  },
}
