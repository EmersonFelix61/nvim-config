vim.g.mapleader = " "

-- Modularização
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- 👉 Carregar Lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Carrega plugins corretamente
require("lazy").setup("config.pluginsets.plugins")

