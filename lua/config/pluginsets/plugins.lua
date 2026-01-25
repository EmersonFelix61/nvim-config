-- lua/config/pluginsets/plugins.lua

-- 1. Função utilitária: checa se o comando existe no sistema e se é possivel rodar
local function has(cmd)
  return vim.fn.executable(cmd) == 1
end

-- 2. Começa a lista com os plugins marotos que rodam liso (100% Lua, sem dependência externa)
local plugins = 
{
  require("config.plugins.nvimtree"),
  require("config.plugins.lualine"),
  require("config.plugins.comment"),
  require("config.plugins.which-key"),
  require("config.plugins.snippets"),
  require("config.plugins.catppuccin")
}

-- Função que avisa se não carregar algum plugin
local missing = {}

--Tabela de plugins pra teste de dependencias
local extras = 
{
  {
    name = "Treesitter",
    plugin = "config.plugins.treesitter",
    deps = {"make"}
  },
  {
    name = "telescope",
    plugin = "config.plugins.telescope",
    deps = {"rg", "fd"}
  },
  {
    name = "Gitsigns",
    plugin = "config.plugins.gitsigns",
    deps = {"git"}
  },
  {
    name = "LSPconfig e CMP (web)",
    plugin = {"config.plugins.lspconfig", "config.plugins.cmp"},
    deps = {"node", "npm"}
  },
  {
    name = "clangd (c/c++)",
    deps = {"clangd"} -- Não é plugin precisa de dependencia, precisa ser testado.
  },
  {
    name = "nvim-autopairs",
    plugin = "config.plugins.autopairs",
    deps = {}
  },
  {
    name = "mini.surround",
    plugin = "config.plugins.surround",
    deps = {}
  },
  {
    name = "indent-blankline",
    plugin = "config.plugins.indentline",
    deps = {}
  },
  {
    name = "toggleterm.nvim",
    plugin = "config.plugins.toggleterm",
    deps = {}
  },
  {
    name = "Mini Icons",
    plugin = "config.plugins.miniicons",
    deps = {} -- Não é plugin, mas precisa que faça clone de git@github.com:echasnovski/mini.icons.git'
  },
  {
    name = "Snippets VSCode",
    plugin = "config.plugins.snippets",
    deps = {} -- sem dependências externas
  },
}
for _, extra in ipairs(extras) do
  local ok = true
  for _, dep in ipairs(extra.deps) do
    if not has(dep) then
      ok = false
      table.insert(missing, extra.name .. "(Aqui tu não tem: " .. dep .. "), se lascou...")
      break
    end
  end

  if ok and extra.plugin then
    if type(extra.plugin) == "table" then
      for _, plug in ipairs(extra.plugin) do
        table.insert(plugins, require(plug))
      end
    else
      table.insert(plugins, require(extra.plugin))
    end
  end
end

if #missing > 0 then
  vim.schedule(function()
    vim.notify("Plugins com as perna quebrada: " .. table.concat(missing, ", "), vim.log.levels.WARN)
  end)
end

return plugins
