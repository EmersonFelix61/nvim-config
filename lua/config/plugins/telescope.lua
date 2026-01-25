return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- requisito obrigatório
  },
  config = function()
    require("telescope").setup()
  end,
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Buscar arquivos" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Buscar texto (grep)" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buscar buffers abertos" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Buscar na ajuda" },
  },
  cmd = "Telescope",
}
