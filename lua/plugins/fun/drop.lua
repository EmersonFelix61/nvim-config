return {
  {
    "folke/drop.nvim",
    config = function()
      require("drop").setup({
        theme = "snow",
        max = 100,
        interval = 30,
      })
    end,
  },
}
