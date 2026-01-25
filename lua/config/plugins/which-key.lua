return {
  "folke/which-key.nvim",
  lazy = false,
  config = function()
    vim.g.mapleader = " "

    local wk = require("which-key")

    wk.setup({
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 10,
        },
      },
    })

    wk.add({
      { "<leader>f", group = "Arquivo" },
      { "<leader>fs", ":w<CR>", desc = "Salvar" },
      { "<leader>fq", ":q<CR>", desc = "Fechar buffer" },
      { "<leader>p", group = "Plugins" },
      { "<leader>pu", ":Lazy update<CR>", desc = "Atualizar plugins" },
      { "<leader>t", "<cmd>echo 'Funcionou'<CR>", desc = "Teste" },
    }, { mode = "n" })
  end
}
