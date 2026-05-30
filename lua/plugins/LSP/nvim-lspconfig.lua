return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				-- LÓGICA DE DESTAQUE DE VARIÁVEIS (Document Highlight)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					local highlight_group = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					
					-- Destaca ao parar o cursor
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})

					-- Limpa o destaque ao mover o cursor
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})

					-- Limpa tudo quando o LSP desconectar
					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end
			end,
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		
		local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
		end

		local function path_exists(path)
			return vim.uv.fs_stat(path) ~= nil
		end

		local function unique_insert(list, seen, value)
			if value and value ~= "" and not seen[value] then
				seen[value] = true
				table.insert(list, value)
			end
		end

		local function clangd_fallback_flags(root_dir)
			local flags = { "-Wall", "-Wextra", "-Werror" }
			local seen = {}

			local function add_include(path)
				if not vim.startswith(path, "/") then
					path = vim.fs.normalize(root_dir .. "/" .. path)
				end
				if path_exists(path) then
					unique_insert(flags, seen, "-I" .. path)
				end
			end

			for _, dir in ipairs({ "includes", "include", "inc", "libft", "libft/includes", "libft/include" }) do
				add_include(dir)
			end

			local makefile = root_dir .. "/Makefile"
			if path_exists(makefile) then
				local make_vars = {}
				for line in io.lines(makefile) do
					local name, value = line:match("^%s*([%w_]+)%s*:?=%s*(.-)%s*$")
					if name and value then
						make_vars[name] = value:gsub("#.*$", ""):gsub("%s+$", "")
					end
				end

				for line in io.lines(makefile) do
					for include in line:gmatch("%-I%s*([^%s\\]+)") do
						include = include:gsub("%$%(([%w_]+)%)", make_vars):gsub("%${([%w_]+)}", make_vars)
						add_include(include)
					end
				end
			end

			return flags
		end

		local function clangd_root_dir(bufnr_or_fname, on_dir)
			local fname = type(bufnr_or_fname) == "number" and vim.api.nvim_buf_get_name(bufnr_or_fname) or bufnr_or_fname
			local root_dir = vim.fs.root(fname, { "compile_commands.json", "compile_flags.txt", "Makefile", ".git" })

			if on_dir then
				on_dir(root_dir)
			end

			return root_dir
		end

		local lspconfig = require("lspconfig")
		local servers = {
			clangd = {
				root_dir = clangd_root_dir,
				root_markers = { "compile_commands.json", "compile_flags.txt", "Makefile", ".git" },
				before_init = function(_, config)
					config.init_options = vim.tbl_deep_extend("force", config.init_options or {}, {
						fallbackFlags = clangd_fallback_flags(config.root_dir or vim.uv.cwd()),
					})
				end,
				on_new_config = function(new_config, root_dir)
					new_config.init_options = vim.tbl_deep_extend("force", new_config.init_options or {}, {
						fallbackFlags = clangd_fallback_flags(root_dir),
					})
				end,
			},
			lua_ls = { settings = { Lua = { diagnostics = { disable = { 'missing-fields' } } } } },
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, { "stylua" })
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		if vim.lsp.config then
			for server_name, server in pairs(servers) do
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
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
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					lspconfig[server_name].setup(server)
				end,
			}
		end

		require("mason-lspconfig").setup(mason_lspconfig_opts)

		if vim.lsp.config then
			for server_name, _ in pairs(servers) do
				vim.lsp.enable(server_name)
			end
		end
	end,
}
