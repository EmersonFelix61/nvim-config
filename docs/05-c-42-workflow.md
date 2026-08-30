# C/42 Workflow

## What Is Configured

- `clangd`: LSP for C/C++.
- `42-NorminetteNvim`: Norminette integration.
- `c_formatter_42`: formatter used by Conform for C files.
- `nvim-dap` + `codelldb`: C/C++ debugging.
- `42-header.nvim`: 42 header through `<F1>`.

## Recommended Flow

1. Open the C project with `nvim .`.
2. Open files with `<leader>sf` or Neo-tree.
3. Check LSP with `:LspInfo`.
4. Use `clangd` diagnostics while editing.
5. Run Norminette with `<leader>n`.
6. Format C with `<leader>f` if `c_formatter_42` is available.
7. Compile in the terminal with `<leader>tt`.
8. Before evaluation, run `make`, `norminette`, and manual tests.

## clangd

`clangd` is configured through `lua/kickoff42/clangd.lua` and enabled in `lua/plugins/lsp/lspconfig.lua`.

Check it with:

```vim
:LspInfo
```

If the LSP does not start, check `:Mason`, `:checkhealth kickoff42`, and whether the project needs a `compile_commands.json`.

## Norminette

| Action | Use |
| --- | --- |
| Run Norminette | `<leader>n` |
| Norminette size action | `<leader>ns` |

Check the executable:

```sh
which norminette
norminette --version
```

If it does not exist:

```sh
python3 -m pip install --user norminette
```

## c_formatter_42

Conform uses `c_formatter_42` for C files.

Check it with:

```sh
which c_formatter_42
c_formatter_42 --help
```

If it does not exist:

```sh
python3 -m pip install --user c-formatter-42
```

Found issue: in environments without `c_formatter_42` in `PATH`, `<leader>f` cannot format C according to the 42 style.

## 42 Header

| Action | Use |
| --- | --- |
| Insert/update header | `<F1>` or `:Stdheader` |

The user and email values are configured in `lua/plugins/42/header.lua`.

## C/C++ Debugging

DAP uses `codelldb`, installed by Mason when possible.

1. Compile with debug symbols, for example `-g`.
2. Place a breakpoint with `<leader>db`.
3. Start with `<F5>`.
4. Enter the executable path when prompted.
5. Use `<leader>du` to open the debugger UI.
