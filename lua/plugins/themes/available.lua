return {
  {
    'rebelot/kanagawa.nvim',
    opts = {
      -- Mantém a variante Wave; estas opções só entram em vigor ao selecioná-la.
      theme = 'wave',
      undercurl = true,
      dimInactive = true,
      terminalColors = true,
      colors = {
        theme = {
          all = {
            ui = {
              -- Integra a coluna de sinais ao fundo sem alterar a paleta Wave.
              bg_gutter = 'none',
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Uma superfície consistente para hover, assinatura, completion e popups.
          NormalFloat = { bg = theme.ui.bg_m3 },
          FloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          FloatTitle = { fg = theme.ui.special, bg = theme.ui.bg_m3, bold = true },

          -- Telescope preserva seu layout, mas passa a usar a mesma superfície
          -- e seleção dos outros menus transitórios.
          TelescopePromptNormal = { bg = theme.ui.bg_m3 },
          TelescopePromptBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
          TelescopeResultsBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          TelescopePreviewNormal = { bg = theme.ui.bg_m3 },
          TelescopePreviewBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          TelescopeTitle = { fg = theme.ui.special, bg = theme.ui.bg_m3, bold = true },
          TelescopeSelection = { bg = theme.ui.bg_p2 },

          -- Pmenu é compartilhado por nvim-cmp e pelo popupmenu do Noice.
          Pmenu = { fg = theme.ui.pmenu.fg, bg = theme.ui.bg_m3 },
          PmenuSel = { fg = theme.ui.pmenu.fg_sel, bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- Which-key, Neo-tree em modo flutuante e Noice herdam a mesma
          -- linguagem visual sem reposicionar nenhuma janela.
          WhichKeyNormal = { bg = theme.ui.bg_m3 },
          WhichKeyBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          WhichKeyTitle = { fg = theme.ui.special, bg = theme.ui.bg_m3, bold = true },
          NeoTreeFloatNormal = { bg = theme.ui.bg_m3 },
          NeoTreeFloatBorder = { fg = theme.ui.float.fg_border, bg = theme.ui.bg_m3 },
          NeoTreeFloatTitle = { fg = theme.ui.special, bg = theme.ui.bg_m3, bold = true },
          NeoTreeCursorLine = { bg = theme.ui.bg_p2 },
          NoiceCmdlinePopupBorder = { fg = theme.ui.float.fg_border },
          NoiceCmdlinePopupTitle = { fg = theme.ui.special, bold = true },
        }
      end,
    },
  },
  { 'Yazeed1s/oh-lucy.nvim' },
  { 'scottmckendry/cyberdream.nvim' },
  { 'cpea2506/one_monokai.nvim' },
  { 'rose-pine/neovim', name = 'rose-pine' },
  { 'maxmx03/fluoromachine.nvim' },
}
