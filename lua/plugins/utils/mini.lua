return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',

  config = function()
    local i18n = require 'config.i18n'

    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Move lines and visual selections with Alt + hjkl
    require('mini.move').setup {
      mappings = {
        -- Move visual selection
        left = '<A-h>',
        right = '<A-l>',
        down = '<A-j>',
        up = '<A-k>',

        -- Move current line
        line_left = '<A-h>',
        line_right = '<A-l>',
        line_down = '<A-j>',
        line_up = '<A-k>',
      },
    }

    -- Comments
    require('mini.comment').setup()

    -- Estende f/F/t/T e ; sem trocar a gramática dos motions nativos:
    -- alcança várias linhas, destaca alvos e repete o último salto.
    require('mini.jump').setup()

    -- Labels iterativos para saltos dentro da janela atual. Os atalhos ficam
    -- sob <leader>j para manter <CR> e todos os motions clássicos intactos.
    local jump2d = require 'mini.jump2d'
    jump2d.setup {
      labels = 'asdfghjklqwertyuiopzxcvbnm',
      view = {
        dim = false,
        n_steps_ahead = 1,
      },
      allowed_windows = {
        current = true,
        not_current = false,
      },
      mappings = {
        start_jumping = '',
      },
    }

    local function map_jump(keys, opts, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
        jump2d.start(opts)
      end, { desc = desc })
    end

    map_jump('<leader>j', jump2d.builtin_opts.default, i18n.t 'map.jump_labels')
    map_jump('<leader>jw', jump2d.builtin_opts.word_start, i18n.t 'map.jump_words')
    map_jump('<leader>jc', jump2d.builtin_opts.single_character, i18n.t 'map.jump_character')
    map_jump('<leader>jl', jump2d.builtin_opts.line_start, i18n.t 'map.jump_line')

    -- Statusline
    local statusline = require 'mini.statusline'

    statusline.setup {
      use_icons = vim.g.have_nerd_font,

      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }

          local git = statusline.section_git { trunc_width = 40 }

          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }

          local filename = statusline.section_filename { trunc_width = 140 }

          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }

          local location = statusline.section_location { trunc_width = 75 }

          return statusline.combine_groups {
            {
              hl = mode_hl,
              strings = { mode },
            },

            {
              hl = 'MiniStatuslineDevinfo',
              strings = { git, diagnostics },
            },

            '%<',

            {
              hl = 'MiniStatuslineFilename',
              strings = { filename },
            },

            '%=',

            {
              hl = 'MiniStatuslineFilename',
              strings = { '' },
            },

            '%=',

            {
              hl = 'MiniStatuslineFileinfo',
              strings = { fileinfo },
            },

            {
              hl = mode_hl,
              strings = { location },
            },
          }
        end,
      },
    }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- ... and there is more!
    -- Check out: https://github.com/echasnovski/mini.nvim
  end,
}
