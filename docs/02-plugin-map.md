# Plugin Map

This map lists plugins imported by `init.lua`. Presets or modules that are not imported are not documented as active behavior.

## Navigation

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `nvim-telescope/telescope.nvim` | Finds files, text, buffers, symbols, diagnostics | Whenever you need to find something | Essential | `lua/plugins/utils/telescope.lua` |
| `nvim-neo-tree/neo-tree.nvim` | File explorer | When you want a tree view | Complementary | `lua/plugins/utils/neo-tree.lua` |
| `echasnovski/mini.nvim` | Jump, surround, comment, move, statusline | Daily editing and fast movement | Essential | `lua/plugins/utils/mini.lua` |
| `nvim-pack/nvim-spectre` | Project/file search and replace | Text refactors | Complementary | `lua/plugins/utils/spectre.lua` |
| `romgrk/barbar.nvim` | Bufferline and buffer actions | Working with several buffers | Complementary | `lua/plugins/fun/barbar.lua` |

## LSP

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `neovim/nvim-lspconfig` | Configures LSP servers | C, Python, Lua | Essential | `lua/plugins/lsp/lspconfig.lua` |
| `williamboman/mason.nvim` | Installs external tools | Managing binaries | Essential | `lua/plugins/lsp/lspconfig.lua` |
| `williamboman/mason-lspconfig.nvim` | Connects Mason and LSP config | Enabling installed servers | Essential | `lua/plugins/lsp/lspconfig.lua` |
| `WhoIsSethDaniel/mason-tool-installer.nvim` | Ensures external tools are installed | Installing black, isort, flake8, codelldb, etc. | Essential | `lua/plugins/lsp/lspconfig.lua` |
| `j-hui/fidget.nvim` | Shows LSP progress | Visual feedback | Complementary | `lua/plugins/lsp/lspconfig.lua` |
| `folke/lazydev.nvim` | Improves Lua/Neovim LSP | Editing this config | Complementary | `lua/plugins/lsp/lazydev.lua` |

Configured servers: `clangd`, `pyright`, `ruff`, `lua_ls`.

## Completion

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `hrsh7th/nvim-cmp` | Completion menu | Manual code completion | Essential | `lua/plugins/lsp/completion.lua` |
| `L3MON4D3/LuaSnip` | Snippets | Expanding snippets used by completion | Complementary | `lua/plugins/lsp/completion.lua` |
| `saadparwaiz1/cmp_luasnip` | LuaSnip source for cmp | Snippet completion | Complementary | `lua/plugins/lsp/completion.lua` |
| `hrsh7th/cmp-nvim-lsp` | LSP source for cmp | LSP completion | Essential | `lua/plugins/lsp/completion.lua` |
| `hrsh7th/cmp-path` | Path completion | Typing paths | Complementary | `lua/plugins/lsp/completion.lua` |

Automatic completion is disabled. Use `<C-Space>`.

## Lint and Formatting

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `stevearc/conform.nvim` | Formatting | `<leader>f` or save when configured | Essential | `lua/plugins/lsp/formatting.lua` |
| `mfussenegger/nvim-lint` | Diagnostics from external linters | Visual Flake8 diagnostics for Python | Complementary | `lua/plugins/42/flake8.lua`, `lua/kickoff42/flake8.lua` |
| `MrSloth-dev/42-NorminetteNvim` | Norminette integration | 42 C projects | Essential for 42 | `lua/plugins/42/norminette.lua` |

Tools ensured by Mason: `black`, `isort`, `flake8`, `stylua`, `clang-format`, `codelldb`. Found issue: `black` and `isort` are installed, but Python is not wired to Conform in the current config.

## Debug

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `mfussenegger/nvim-dap` | Debug Adapter Protocol | C/C++ debugging | Essential for debugging | `lua/plugins/debug/dap.lua` |
| `rcarriga/nvim-dap-ui` | Debugger UI | Inspecting variables, scopes, and stacks | Complementary | `lua/plugins/debug/dap.lua` |
| `theHamsta/nvim-dap-virtual-text` | Inline runtime values | Reading state while debugging | Complementary | `lua/plugins/debug/dap.lua` |

Python debugging is not configured at this stage.

## Git

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `lewis6991/gitsigns.nvim` | Git signs and hunk actions | View/stage/reset changes | Essential | `lua/plugins/utils/gitsigns.lua` |
| `sindrets/diffview.nvim` | Diffs and file history | Reviewing changes | Complementary | `lua/plugins/utils/diffview.lua` |
| `NeogitOrg/neogit` | Full Git UI | Status, stage, commit | Complementary | `lua/plugins/utils/neogit.lua` |

## Terminal

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `akinsho/toggleterm.nvim` | Persistent integrated terminal | Running `make`, `python`, tests, and commands | Essential | `lua/plugins/utils/toggleterm.lua` |

## UI

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `folke/noice.nvim` | Message and command UI | Visual feedback | Complementary | `lua/plugins/fun/noice.lua` |
| `rcarriga/nvim-notify` | Notifications used by Noice | Notification display | Complementary | `lua/plugins/fun/noice.lua` |
| `folke/which-key.nvim` | Keymap discovery | When you forget mappings | Essential | `lua/plugins/utils/which-key.lua` |
| `folke/snacks.nvim` | Startup dashboard | Start screen | Complementary | `lua/plugins/dashboard/snacks.lua` |
| `folke/tokyonight.nvim` | Default theme | Main look | Essential visual | `lua/plugins/themes/tokyonight.lua` |
| `catppuccin/nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/catppuccin.lua` |
| `rebelot/kanagawa.nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `Yazeed1s/oh-lucy.nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `scottmckendry/cyberdream.nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `cpea2506/one_monokai.nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `rose-pine/neovim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `maxmx03/fluoromachine.nvim` | Alternative theme | Changing the look | Complementary | `lua/plugins/themes/available.lua` |
| `zaldih/themery.nvim` | Theme manager | Switching themes | Complementary | `lua/plugins/themes/themery.lua` |
| `MrSloth-dev/Switcheroo.nvim` | Theme switching UI | Verify manual usage | Complementary | `lua/plugins/themes/switcheroo.lua` |
| `folke/drop.nvim` | Visual effect | Aesthetic only | Complementary | `lua/plugins/fun/drop.lua` |

There is no `lualine` configuration. The statusline comes from `mini.statusline`.

## Productivity

| Plugin | What it does | When to use it | Role | Config file |
| --- | --- | --- | --- | --- |
| `windwp/nvim-autopairs` | Inserts matching pairs | Daily editing | Complementary | `lua/plugins/utils/autopairs.lua` |
| `lukas-reineke/indent-blankline.nvim` | Indentation guides | Reading blocks | Complementary | `lua/plugins/utils/indent_line.lua` |
| `nvim-treesitter/nvim-treesitter` | Highlighting and parsing | Code in general | Essential | `lua/plugins/utils/nvim-treesitter.lua` |
| `nvim-treesitter/nvim-treesitter-context` | Sticky code context | Long files | Complementary | `lua/plugins/utils/nvim-treesitter.lua` |
| `folke/todo-comments.nvim` | Highlights TODO/FIXME comments | Reviewing pending work | Complementary | `lua/plugins/utils/todo-comments.lua` |
| `folke/persistence.nvim` | Sessions | Verify plugin commands | Complementary | `lua/plugins/dashboard/persistence.lua` |
| `Diogo-ss/42-header.nvim` | 42 header | Creating/updating headers | Essential for 42 | `lua/plugins/42/header.lua` |
| `Eandrju/cellular-automaton.nvim` | Visual effect | Verify manual command | Complementary | `lua/plugins/fun/cellular.lua` |

## Support Dependencies

These plugins are installed as dependencies of the active specs. They are not the main workflow entry point, but other plugins depend on them.

| Plugin | Used by | Notes |
| --- | --- | --- |
| `nvim-lua/plenary.nvim` | Telescope, Neo-tree, Neogit, Diffview, Spectre, Todo Comments, Norminette | Common Lua utility dependency |
| `nvim-tree/nvim-web-devicons` | Telescope, Neo-tree, Barbar | File icons, enabled when Nerd Font support is enabled |
| `MunifTanjim/nui.nvim` | Neo-tree, Noice | UI components |
| `nvim-telescope/telescope-fzf-native.nvim` | Telescope | Native sorter, built with `make` when available |
| `nvim-telescope/telescope-ui-select.nvim` | Telescope | Replaces `vim.ui.select` with Telescope UI |
| `nvim-neotest/nvim-nio` | nvim-dap-ui | Async IO dependency for DAP UI |
| `rktjmp/lush.nvim` | Switcheroo | Theme/color dependency |
| `echasnovski/mini.icons` | Norminette plugin | Icons dependency |
