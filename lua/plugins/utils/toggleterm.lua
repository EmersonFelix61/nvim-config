return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require 'toggleterm'
    local terms = require 'toggleterm.terminal'
    local commandline = require 'toggleterm.commandline'
    local Terminal = terms.Terminal
    local directory_terminals = {}

    local function normalize_directory(path)
      return vim.fs.normalize(vim.fn.fnamemodify(path, ':p'))
    end

    local function current_buffer_directory()
      local path = vim.api.nvim_buf_get_name(0)

      if path ~= '' and vim.bo.buftype == '' and vim.fn.filereadable(path) == 1 then
        return normalize_directory(vim.fn.fnamemodify(path, ':p:h'))
      end

      return normalize_directory(vim.fn.getcwd())
    end

    local function toggle_directory_terminal()
      local _, focused_term = terms.identify()

      if focused_term then
        focused_term:toggle()
        return
      end

      local dir = current_buffer_directory()

      if not directory_terminals[dir] then
        directory_terminals[dir] = Terminal:new {
          dir = dir,
        }
      end

      directory_terminals[dir]:toggle()
    end

    toggleterm.setup {
      size = 20,
      open_mapping = [[<C-t>]], -- Abre e fecha com Ctrl + t
      hide_numbers = true,
      shade_terminals = true,
      direction = 'horizontal', -- Abre na parte de baixo
      close_on_exit = true,
    }

    vim.api.nvim_create_user_command('ToggleTerm', function(opts)
      local has_count = opts.count and opts.count >= 1

      if opts.args ~= '' or has_count then
        toggleterm.toggle_command(opts.args, opts.count)
        return
      end

      toggle_directory_terminal()
    end, {
      count = true,
      complete = commandline.toggle_term_complete,
      nargs = '*',
    })
  end,
}
