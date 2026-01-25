--Plugin de comentarios usando gcc, gco ou gcO
return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup()
  end,
}
