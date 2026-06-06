local M = {}

local default_lang = "pt_BR"
local lang_file = vim.fn.stdpath("config") .. "/.nvim-lang"

local translations = {
	pt_BR = {
		["cmd.lang.desc"] = "Alternar idioma da config",
		["cmd.lang.invalid"] = "Idioma inválido. Use: pt_BR, en ou toggle.",
		["cmd.lang.set"] = "Idioma da config: %s",
		["cmd.lang.usage"] = "Use :Idioma pt_BR, :Idioma en ou :Idioma toggle",

		["common.format_buffer"] = "[F]ormatar buffer",

		["diagnostics.full_error"] = "LSP: mostrar erro completo",
		["diagnostics.hide_virtual_text"] = "LSP: ocultar texto virtual",
		["diagnostics.quickfix"] = "Abrir lista quickfix de diagnósticos",
		["diagnostics.show_virtual_text"] = "LSP: mostrar texto virtual",

		["git.blame_line"] = "Git: blame da linha",
		["git.close_diff"] = "Git: fechar diff",
		["git.file_history"] = "Git: histórico do arquivo",
		["git.inline_blame"] = "Git: alternar blame inline",
		["git.list_hunks"] = "Git: listar hunks",
		["git.next_hunk"] = "Git: próximo hunk",
		["git.open_diff"] = "Git: abrir diff do projeto",
		["git.open_neogit"] = "Git: abrir Neogit",
		["git.prev_hunk"] = "Git: hunk anterior",
		["git.preview_hunk"] = "Git: pré-visualizar hunk",
		["git.project_history"] = "Git: histórico do projeto",
		["git.reset_hunk"] = "Git: desfazer hunk",
		["git.stage_hunk"] = "Git: preparar hunk",
		["git.word_diff"] = "Git: alternar diff por palavra",

		["health.executable_found"] = "Executável encontrado: '%s'",
		["health.executable_missing"] = "Executável não encontrado: '%s'",
		["health.info"] = [[NOTA: Nem todo aviso é algo que precisa ser corrigido.

  Corrija apenas avisos de plugins e linguagens que você pretende usar.
    O Mason mostra avisos para linguagens que não estão instaladas.
    Você não precisa instalar, a menos que queira usar essas linguagens!]],
		["health.nvim_outdated"] = "Neovim desatualizado: '%s'. Atualize para a versão estável mais recente ou nightly",
		["health.nvim_version"] = "Versão do Neovim: '%s'",
		["health.system_info"] = "Informações do sistema: ",

		["lang.toggle"] = "Idioma: alternar PT-BR/inglês",

		["lsp.code_action"] = "LSP: ação de código",
		["lsp.declaration"] = "LSP: ir para declaração",
		["lsp.definition"] = "LSP: ir para definição",
		["lsp.document_symbols"] = "LSP: símbolos do documento",
		["lsp.implementation"] = "LSP: ir para implementação",
		["lsp.references"] = "LSP: referências",
		["lsp.rename"] = "LSP: renomear",
		["lsp.type_definition"] = "LSP: definição de tipo",
		["lsp.workspace_symbols"] = "LSP: símbolos do workspace",

		["map.buffer_close"] = "Fechar buffer atual",
		["map.buffer_close_left"] = "Fechar buffers à esquerda",
		["map.buffer_close_others"] = "Fechar outros buffers",
		["map.buffer_close_picker"] = "Escolher buffer para fechar",
		["map.buffer_close_right"] = "Fechar buffers à direita",
		["map.buffer_move_left"] = "Mover buffer para esquerda",
		["map.buffer_move_right"] = "Mover buffer para direita",
		["map.buffer_next"] = "Próximo buffer",
		["map.buffer_order_directory"] = "Ordenar buffers por diretório",
		["map.buffer_order_extension"] = "Ordenar buffers por extensão",
		["map.buffer_pick"] = "Escolher buffer",
		["map.buffer_pin"] = "Fixar/desfixar buffer",
		["map.buffer_previous"] = "Buffer anterior",
		["map.copilot_chat"] = "Alternar chat do Copilot",
		["map.escape_normal"] = "Sair para o modo normal",
		["map.escape_terminal"] = "Sair do modo terminal",
		["map.focus_down"] = "Mover foco para a janela de baixo",
		["map.focus_left"] = "Mover foco para a janela da esquerda",
		["map.focus_right"] = "Mover foco para a janela da direita",
		["map.focus_up"] = "Mover foco para a janela de cima",
		["map.highlight_yank"] = "Destacar texto copiado",
		["map.neotree_reveal"] = "Neo-tree: revelar arquivo atual",
		["map.neotree_toggle"] = "Alternar Neo-tree",
		["map.spectre_current_file"] = "Spectre: buscar no arquivo atual",
		["map.spectre_current_word"] = "Spectre: buscar palavra atual",
		["map.spectre_selection"] = "Spectre: buscar seleção",
		["map.spectre_toggle"] = "Alternar Spectre",
		["map.toggle_terminal"] = "Alternar terminal",
		["map.which_key_g"] = "Mostrar atalhos de g",
		["map.which_key_leader"] = "Mostrar atalhos <leader>",
		["map.which_key_z"] = "Mostrar atalhos de z",

		["notify.telescope_rg_missing"] = "O grep do Telescope precisa do ripgrep (`rg`) no PATH",

		["telescope.buffers"] = "[ ] Encontrar buffers abertos",
		["telescope.current_buffer"] = "[/] Buscar no buffer atual",
		["telescope.diagnostics"] = "[S] Buscar [D]iagnósticos",
		["telescope.files"] = "[S] Buscar arquivos",
		["telescope.grep"] = "[S] Buscar com [G]rep",
		["telescope.help"] = "[S] Buscar ajuda",
		["telescope.keymaps"] = "[S] Buscar atalhos",
		["telescope.neovim_files"] = "[S] Buscar arquivos do [N]eovim",
		["telescope.oldfiles"] = "[S] Buscar arquivos recentes",
		["telescope.open_files"] = "[S] Buscar nos arquivos abertos",
		["telescope.open_files_title"] = "Grep ao vivo nos arquivos abertos",
		["telescope.resume"] = "[S] Retomar busca",
		["telescope.select"] = "[S] Selecionar busca do Telescope",
		["telescope.word"] = "[S] Buscar palavra atual",

		["which.buffer"] = "[B]uffers",
		["which.code"] = "[C]ódigo",
		["which.document"] = "[D]ocumento",
		["which.git"] = "[G]it",
		["which.git_hunk"] = "Git [H]unk",
		["which.lang"] = "[L]inguagem",
		["which.rename"] = "[R]enomear",
		["which.search"] = "[S]Buscar",
		["which.toggle"] = "[T]Alternar",
		["which.workspace"] = "[W]orkspace",
	},
	en = {
		["cmd.lang.desc"] = "Switch config language",
		["cmd.lang.invalid"] = "Invalid language. Use: pt_BR, en, or toggle.",
		["cmd.lang.set"] = "Config language: %s",
		["cmd.lang.usage"] = "Use :Idioma pt_BR, :Idioma en, or :Idioma toggle",

		["common.format_buffer"] = "[F]ormat buffer",

		["diagnostics.full_error"] = "LSP: show full error",
		["diagnostics.hide_virtual_text"] = "LSP: hide virtual text",
		["diagnostics.quickfix"] = "Open diagnostic quickfix list",
		["diagnostics.show_virtual_text"] = "LSP: show virtual text",

		["git.blame_line"] = "Git: blame current line",
		["git.close_diff"] = "Git: close diff",
		["git.file_history"] = "Git: file history",
		["git.inline_blame"] = "Git: toggle inline blame",
		["git.list_hunks"] = "Git: list hunks",
		["git.next_hunk"] = "Git: next hunk",
		["git.open_diff"] = "Git: open project diff",
		["git.open_neogit"] = "Git: open Neogit",
		["git.prev_hunk"] = "Git: previous hunk",
		["git.preview_hunk"] = "Git: preview hunk",
		["git.project_history"] = "Git: project history",
		["git.reset_hunk"] = "Git: reset hunk",
		["git.stage_hunk"] = "Git: stage hunk",
		["git.word_diff"] = "Git: toggle word diff",

		["health.executable_found"] = "Found executable: '%s'",
		["health.executable_missing"] = "Could not find executable: '%s'",
		["health.info"] = [[NOTE: Not every warning is a 'must-fix' in `:checkhealth`

  Fix only warnings for plugins and languages you intend to use.
    Mason will give warnings for languages that are not installed.
    You do not need to install, unless you want to use those languages!]],
		["health.nvim_outdated"] = "Neovim out of date: '%s'. Upgrade to latest stable or nightly",
		["health.nvim_version"] = "Neovim version is: '%s'",
		["health.system_info"] = "System Information: ",

		["lang.toggle"] = "Language: toggle PT-BR/English",

		["lsp.code_action"] = "LSP: code action",
		["lsp.declaration"] = "LSP: go to declaration",
		["lsp.definition"] = "LSP: go to definition",
		["lsp.document_symbols"] = "LSP: document symbols",
		["lsp.implementation"] = "LSP: go to implementation",
		["lsp.references"] = "LSP: references",
		["lsp.rename"] = "LSP: rename",
		["lsp.type_definition"] = "LSP: type definition",
		["lsp.workspace_symbols"] = "LSP: workspace symbols",

		["map.buffer_close"] = "Close current buffer",
		["map.buffer_close_left"] = "Close buffers to the left",
		["map.buffer_close_others"] = "Close other buffers",
		["map.buffer_close_picker"] = "Pick buffer to close",
		["map.buffer_close_right"] = "Close buffers to the right",
		["map.buffer_move_left"] = "Move buffer left",
		["map.buffer_move_right"] = "Move buffer right",
		["map.buffer_next"] = "Next buffer",
		["map.buffer_order_directory"] = "Order buffers by directory",
		["map.buffer_order_extension"] = "Order buffers by extension",
		["map.buffer_pick"] = "Pick buffer",
		["map.buffer_pin"] = "Pin/unpin buffer",
		["map.buffer_previous"] = "Previous buffer",
		["map.copilot_chat"] = "Toggle Copilot Chat",
		["map.escape_normal"] = "Exit to normal mode",
		["map.escape_terminal"] = "Exit terminal mode",
		["map.focus_down"] = "Move focus to the lower window",
		["map.focus_left"] = "Move focus to the left window",
		["map.focus_right"] = "Move focus to the right window",
		["map.focus_up"] = "Move focus to the upper window",
		["map.highlight_yank"] = "Highlight yanked text",
		["map.neotree_reveal"] = "Neo-tree: reveal current file",
		["map.neotree_toggle"] = "Toggle Neo-tree",
		["map.spectre_current_file"] = "Spectre: search current file",
		["map.spectre_current_word"] = "Spectre: search current word",
		["map.spectre_selection"] = "Spectre: search selection",
		["map.spectre_toggle"] = "Toggle Spectre",
		["map.toggle_terminal"] = "Toggle terminal",
		["map.which_key_g"] = "Show g keymaps",
		["map.which_key_leader"] = "Show <leader> keymaps",
		["map.which_key_z"] = "Show z keymaps",

		["notify.telescope_rg_missing"] = "Telescope grep requires ripgrep (`rg`) in PATH",

		["telescope.buffers"] = "[ ] Find existing buffers",
		["telescope.current_buffer"] = "[/] Fuzzily search in current buffer",
		["telescope.diagnostics"] = "[S]earch [D]iagnostics",
		["telescope.files"] = "[S]earch [F]iles",
		["telescope.grep"] = "[S]earch by [G]rep",
		["telescope.help"] = "[S]earch [H]elp",
		["telescope.keymaps"] = "[S]earch [K]eymaps",
		["telescope.neovim_files"] = "[S]earch [N]eovim files",
		["telescope.oldfiles"] = "[S]earch Recent Files",
		["telescope.open_files"] = "[S]earch [/] in Open Files",
		["telescope.open_files_title"] = "Live Grep in Open Files",
		["telescope.resume"] = "[S]earch [R]esume",
		["telescope.select"] = "[S]earch [S]elect Telescope",
		["telescope.word"] = "[S]earch current [W]ord",

		["which.buffer"] = "[B]uffers",
		["which.code"] = "[C]ode",
		["which.document"] = "[D]ocument",
		["which.git"] = "[G]it",
		["which.git_hunk"] = "Git [H]unk",
		["which.lang"] = "[L]anguage",
		["which.rename"] = "[R]ename",
		["which.search"] = "[S]earch",
		["which.toggle"] = "[T]oggle",
		["which.workspace"] = "[W]orkspace",
	},
}

local function read_lang()
	local file = io.open(lang_file, "r")
	if not file then
		return default_lang
	end

	local lang = vim.trim(file:read("*a") or "")
	file:close()

	if translations[lang] then
		return lang
	end

	return default_lang
end

vim.g.config_lang = vim.g.config_lang or read_lang()

function M.current()
	return translations[vim.g.config_lang] and vim.g.config_lang or default_lang
end

function M.t(key)
	local lang = M.current()
	return translations[lang][key] or translations[default_lang][key] or key
end

function M.set(lang)
	if lang == "toggle" then
		lang = M.current() == "pt_BR" and "en" or "pt_BR"
	end

	if not translations[lang] then
		return false
	end

	vim.g.config_lang = lang

	local file = io.open(lang_file, "w")
	if file then
		file:write(lang)
		file:close()
	end

	vim.notify(M.t("cmd.lang.set"):format(lang))
	return true
end

function M.which_key_spec()
	return {
		{ "<leader>b", group = M.t("which.buffer") },
		{ "<leader>c", group = M.t("which.code"), mode = { "n", "x" } },
		{ "<leader>d", group = M.t("which.document") },
		{ "<leader>g", group = M.t("which.git") },
		{ "<leader>h", group = M.t("which.git_hunk"), mode = { "n", "v" } },
		{ "<leader>l", group = M.t("which.lang") },
		{ "<leader>r", group = M.t("which.rename") },
		{ "<leader>s", group = M.t("which.search") },
		{ "<leader>t", group = M.t("which.toggle") },
		{ "<leader>w", group = M.t("which.workspace") },
	}
end

function M.apply_runtime()
	local vim_options = vim.fn.stdpath("config") .. "/lua/vim-options.lua"
	dofile(vim_options)

	local ok, which_key = pcall(require, "which-key")
	if ok then
		which_key.add(M.which_key_spec())
	end
end

function M.setup_commands()
	vim.api.nvim_create_user_command("Idioma", function(opts)
		local lang = opts.args
		if lang == "" then
			vim.notify(M.t("cmd.lang.usage"))
			return
		end

		if not M.set(lang) then
			vim.notify(M.t("cmd.lang.invalid"), vim.log.levels.ERROR)
			return
		end

		M.apply_runtime()
	end, {
		nargs = "?",
		complete = function()
			return { "pt_BR", "en", "toggle" }
		end,
		desc = M.t("cmd.lang.desc"),
	})
end

return M
