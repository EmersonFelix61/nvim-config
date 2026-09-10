# Python Workflow

## What Is Configured

- `pyright`: main Python LSP for types, navigation, and diagnostics, with basic type checking limited to open files.
- `ruff`: complementary Python LSP for fast lint feedback. Ruff hover is disabled so Pyright can own hover.
- `flake8`: optional visual diagnostics through `nvim-lint`.
- `black` and `isort`: installed by Mason and run manually by Conform with `<leader>f`. Saving does not format.

## Recommended Flow

1. Open a `.py` file.
2. Check that `pyright` and `ruff` appear in `:LspInfo`.
3. Read signs/underlines and use `<leader>le` for diagnostic details. Inline text starts disabled; `<leader>lt` enables it and `<leader>lf` hides it.
4. Use `<leader>q` to open the diagnostics list.
5. Save normally without formatting. Use `<leader>f` when you want isort followed by Black.
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

The editor explicitly selects `E4`, `E7`, `E9`, and `F` instead of inheriting changing Ruff defaults. These keep basic errors, undefined names, and unused imports without requiring docstrings, type annotations, or removing prints. Pyright still checks types; some errors such as undefined names can be reported by both servers.

Project settings take precedence. To customize a project, create `pyproject.toml` at its root:

```toml
[tool.ruff.lint]
select = ["E4", "E7", "E9", "F"]
# Optional: ignore = ["F401"]
```

`ruff.toml` and `.ruff.toml` are also supported. A project selecting broader rules explicitly can re-enable style checks. The editor uses Ruff's [filesystemFirst setting](https://docs.astral.sh/ruff/editors/settings/#configurationpreference); this editor fallback requires Ruff >= 0.9.8 and does not change terminal Ruff defaults. Use the project file to keep terminal and editor checks consistent.

Flake8 starts disabled by default. Use it when you want an extra explicit style check.

| Action | Use |
| --- | --- |
| Toggle visual Flake8 diagnostics | `<leader>8` |
| Run Flake8 on the current buffer | `:Flake8Check` |
| Toggle Flake8 | `:Flake8Toggle` |

When disabled, Flake8 clears diagnostics created by its namespace and discards results from checks started before disabling. `:Flake8Check` still works with automatic checking off. Flake8 is an optional extra check and can overlap with Ruff; leave automatic checking off unless you need it.

## Python Formatting

Automatic formatting is disabled for every filetype. On explicit `<leader>f`, Conform runs isort with the Black profile, then Black. This avoids conflicting import wrapping between the two formatters. isort uses a Conform-managed temporary file so unsaved buffers also work with isort 8. `:ConformInfo` shows availability and failures. Python does not fall back to LSP formatting, so Ruff does not silently replace Black. Invalid Python can prevent formatting; inspect the error and correct the syntax before retrying.
