return {
  {
    "folke/drop.nvim",
    config = function()
      require("drop").setup({
        theme = "stars",
        max = 100,
        interval = 30,
      })
    end,
  },
}
