return{
  "rafamadriz/friendly-snippets",
  "hrsh7th/cmp-path",
  lazy = true,
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
