# Python Workflow

## What Is Configured

- `pyright`: main Python LSP for types, navigation, and diagnostics.
- `ruff`: complementary Python LSP for fast lint feedback. Ruff hover is disabled so Pyright can own hover.
- `flake8`: optional visual diagnostics through `nvim-lint`.
- `black` and `isort`: installed by Mason, but not wired to Conform for Python in the current config.

## Recommended Flow

1. Open a `.py` file.
2. Check that `pyright` and `ruff` appear in `:LspInfo`.
3. Read inline diagnostics or use `<leader>le`.
4. Use `<leader>q` to open the diagnostics list.
5. Save normally. Verify: current config does not format Python with Black/isort through Conform.
6. Use `<leader>8` when you want additional visual Flake8 diagnostics.
7. Run, test, or debug through the integrated terminal.

## Pyright

Pyright depends on a modern Node.js runtime. If it fails with `SyntaxError: Unexpected token '?'`, the likely cause is Neovim/Mason using an old Node.js.

Inside Neovim:

```vim
:LspInfo
:Mason
:checkhealth kickoff42
```

In the shell:

```sh
which node
node --version
~/.local/share/nvim/mason/bin/pyright-langserver --stdio
```

If the Node.js used by Neovim differs from the shell, see [Troubleshooting](11-troubleshooting.md).

## Ruff vs Flake8

Ruff is active as an LSP and gives continuous feedback while editing.

Flake8 starts disabled by default. Use it when you want an extra explicit style check.

| Action | Use |
| --- | --- |
| Toggle visual Flake8 diagnostics | `<leader>8` |
| Run Flake8 on the current buffer | `:Flake8Check` |
| Toggle Flake8 | `:Flake8Toggle` |

When disabled, Flake8 clears diagnostics created by its namespace.

## Python Formatting

Found issue: `black` and `isort` are installed by Mason, but the Python formatter block in `lua/plugins/lsp/formatting.lua` is commented out. Do not assume saving a Python file runs Black/isort until that is configured and tested.

For now, use the terminal:

```sh
black .
isort .
```

or run them on specific files.
