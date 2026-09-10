local i18n = require 'config.i18n'

local function lsp_format_mode(bufnr)
  local filetype = vim.bo[bufnr].filetype
  if filetype == 'c' or filetype == 'cpp' or filetype == 'python' then
    return 'never'
  end
  return 'fallback'
end

return {
  'stevearc/conform.nvim',
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_format = lsp_format_mode(vim.api.nvim_get_current_buf()),
        }
      end,
      mode = '',
      desc = i18n.t 'common.format_buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      c = { 'c_formatter_42' },
      cpp = { 'clang-format' },
      lua = { 'stylua' },
      python = { 'isort', 'black' },

      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
    formatters = {
      isort = {
        -- isort 8 skips stdin when --filename points to a not-yet-saved buffer.
        stdin = false,
        args = { '--profile', 'black', '$FILENAME' },
      },
      c_formatter_42 = {
        command = 'c_formatter_42',
        stdin = true,
      },
    },
  },
}
