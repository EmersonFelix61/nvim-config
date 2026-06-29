local i18n = require 'config.i18n'

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  version = '*',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local path_separator = package.config:sub(3, 3)
    local local_bin = vim.fs.joinpath(vim.fn.expand '$HOME', '.local', 'bin')
    local path_entries = vim.split(vim.env.PATH or '', path_separator, { plain = true })
    if vim.fn.isdirectory(local_bin) == 1 and not vim.tbl_contains(path_entries, local_bin) then
      vim.env.PATH = local_bin .. path_separator .. (vim.env.PATH or '')
    end

    --  :Telescope help_tags
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local has_rg = function()
      if vim.fn.executable 'rg' == 1 then
        return true
      end

      vim.notify(i18n.t 'notify.telescope_rg_missing', vim.log.levels.ERROR)
      return false
    end

    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = i18n.t 'telescope.help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = i18n.t 'telescope.keymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = i18n.t 'telescope.files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = i18n.t 'telescope.select' })
    vim.keymap.set('n', '<leader>sw', function()
      if not has_rg() then
        return
      end
      builtin.grep_string()
    end, { desc = i18n.t 'telescope.word' })
    vim.keymap.set('n', '<leader>sg', function()
      if not has_rg() then
        return
      end
      builtin.live_grep()
    end, { desc = i18n.t 'telescope.grep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = i18n.t 'telescope.diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = i18n.t 'telescope.resume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = i18n.t 'telescope.oldfiles' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = i18n.t 'telescope.buffers' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = i18n.t 'telescope.current_buffer' })
    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      if not has_rg() then
        return
      end
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = i18n.t 'telescope.open_files_title',
      }
    end, { desc = i18n.t 'telescope.open_files' })
    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = i18n.t 'telescope.neovim_files' })
  end,
}
