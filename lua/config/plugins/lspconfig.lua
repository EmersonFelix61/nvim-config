return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    --HTML, CSS e LUA
    lspconfig.html.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })
    lspconfig.cssls.setup({})
    lspconfig.lua_ls.setup({
      settings = {
        lua = {
          diagnostics = { globals = { "vim" } }
        }
      }
    })
    lspconfig.clangd.setup({
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      filetypes = { "c", "cpp", "objc", "objcpp" },
    })
  end,
}
