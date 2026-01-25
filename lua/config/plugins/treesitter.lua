--nvimtree: um explorer de arquivos lateral
return{
   'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', --atualiza a árvore de sintaxe depois de instalar
    config = function()
    require('nvim-treesitter.configs').setup({
     highlight = { enable = false },
     indent = { enable = true },
   })
  end
}
