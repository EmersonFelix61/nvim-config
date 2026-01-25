  --nvimtree: um explorer de arquivos lateral
return{
   'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- ícones marotos
    config = function()
    require('nvim-tree').setup()
   end
} 
