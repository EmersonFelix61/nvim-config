return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft.python = { 'flake8' }

    require('kickoff42.flake8').setup()
  end,
}
