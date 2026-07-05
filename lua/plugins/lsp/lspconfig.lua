return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', opts = {} },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    local i18n = require 'config.i18n'
    local clangd = require 'kickoff42.clangd'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, i18n.t 'lsp.definition')
        map('gr', require('telescope.builtin').lsp_references, i18n.t 'lsp.references')
        map('gI', require('telescope.builtin').lsp_implementations, i18n.t 'lsp.implementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, i18n.t 'lsp.type_definition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, i18n.t 'lsp.document_symbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, i18n.t 'lsp.workspace_symbols')
        map('<leader>rn', vim.lsp.buf.rename, i18n.t 'lsp.rename')
        map('<leader>ca', vim.lsp.buf.code_action, i18n.t 'lsp.code_action', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, i18n.t 'lsp.declaration')

        -- LÓGICA DE DESTAQUE DE VARIÁVEIS (Document Highlight)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          local highlight_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })

          -- Destaca ao parar o cursor
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })

          -- Limpa o destaque ao mover o cursor
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })

          -- Limpa tudo quando o LSP desconectar
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local has_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
    end

    local lspconfig = require 'lspconfig'
    local servers = {
      clangd = clangd.server_config(),
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'workspace',
              typeCheckingMode = 'basic',
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      ruff = {
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      },
      lua_ls = { settings = { Lua = { diagnostics = { disable = { 'missing-fields' } } } } },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    local tools_to_install = vim.list_extend(vim.deepcopy(ensure_installed), {
      'black',
      'clang-format',
      'codelldb',
      'isort',
      'stylua',
    })
    require('mason-tool-installer').setup { ensure_installed = tools_to_install }

    if vim.lsp.config then
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        vim.lsp.config(server_name, server)
      end
    end

    local mason_lspconfig_opts = { ensure_installed = ensure_installed }
    if vim.lsp.config then
      mason_lspconfig_opts.automatic_enable = false
    else
      mason_lspconfig_opts.handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          lspconfig[server_name].setup(server)
        end,
      }
    end

    require('mason-lspconfig').setup(mason_lspconfig_opts)

    if vim.lsp.config then
      for server_name, _ in pairs(servers) do
        vim.lsp.enable(server_name)
      end
    end
  end,
}
