return {
  'mfussenegger/nvim-dap',
  keys = {
    {
      '<F5>',
      function()
        local filetype = vim.bo.filetype
        if vim.g.kickoff42_codelldb_missing and (filetype == 'c' or filetype == 'cpp') then
          vim.notify('Debug C/C++ indisponível: instale codelldb pelo Mason ou adicione-o ao PATH.', vim.log.levels.WARN)
          return
        end
        require('dap').continue()
      end,
      desc = 'Debug: iniciar/continuar',
    },
    {
      '<F10>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: step over',
    },
    {
      '<F11>',
      function()
        require('dap').step_into()
      end,
      desc = 'Debug: step into',
    },
    {
      '<F12>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: step out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Debug: alternar breakpoint',
    },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'Debug: alternar interface',
    },
  },
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
    },
    'theHamsta/nvim-dap-virtual-text',
  },
  config = function()
    local dap = require 'dap'

    local function path_sep()
      return package.config:sub(1, 1)
    end

    local function is_windows()
      return path_sep() == '\\'
    end

    local function find_codelldb()
      local executable_names = is_windows() and { 'codelldb', 'codelldb.cmd', 'codelldb.exe' } or { 'codelldb' }

      for _, executable_name in ipairs(executable_names) do
        local executable = vim.fn.exepath(executable_name)
        if executable ~= '' and vim.fn.executable(executable) == 1 then
          return executable
        end
      end

      local mason_bin = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin')
      for _, executable_name in ipairs(executable_names) do
        local executable = vim.fs.joinpath(mason_bin, executable_name)
        if vim.fn.executable(executable) == 1 then
          return executable
        end
      end
    end

    local codelldb = find_codelldb()
    if codelldb then
      vim.g.kickoff42_codelldb_missing = false
      dap.adapters.codelldb = {
        type = 'executable',
        command = codelldb,
      }

      dap.configurations.c = {
        {
          name = 'Executar binário C',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Caminho do executável: ', vim.fn.getcwd() .. path_sep(), 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
    else
      vim.g.kickoff42_codelldb_missing = true
    end

    require('dapui').setup()
    require('nvim-dap-virtual-text').setup()
  end,
}
