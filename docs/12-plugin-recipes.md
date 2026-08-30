# Plugin Recipes

## I Want to Find a File

Use `<leader>sf`.

Type part of the filename, select the result, and press `<CR>`.

## I Want to Search for a Word in the Project

Use `<leader>sg`.

This requires `ripgrep` (`rg`). Check it with:

```sh
rg --version
```

## I Want to Rename a Variable

Use `<leader>rn` while the cursor is on the symbol.

This depends on an active LSP client. Check with:

```vim
:LspInfo
```

## I Want to See Where a Function Is Used

Use `gr` on the function name.

For broader symbol search, use `<leader>ws`.

## I Want to Fix a Python Error

1. Open the `.py` file.
2. Check `:LspInfo` for `pyright` and `ruff`.
3. Put the cursor on the diagnostic.
4. Press `<leader>le`.
5. Use `<leader>ca` if the LSP offers an action.
6. Toggle Flake8 with `<leader>8` when you want additional visual style diagnostics.

Found issue: Black/isort are installed but not active through Conform for Python.

## I Want to Fix Norminette Issues

1. Open the C file.
2. Run `<leader>n`.
3. Read the reported issue.
4. Format with `<leader>f` if `c_formatter_42` exists.
5. Run `norminette` in the terminal before submitting.

Check tools:

```sh
which norminette
which c_formatter_42
```

## I Want to Open a Terminal and Run Make

1. Press `<leader>tt`.
2. Run:

```sh
make
```

Use `<C-t><C-t>` inside terminal mode to leave and toggle the terminal.

## I Want to Debug a C Program

1. Compile with debug symbols:

```sh
cc -g main.c -o main
```

2. Put a breakpoint with `<leader>db`.
3. Press `<F5>`.
4. Enter the executable path.
5. Open DAP UI with `<leader>du`.
6. Step with `<F10>`, `<F11>`, and `<F12>`.

## I Want to See Git Changes

Use Gitsigns first:

| Goal | Keymap |
| --- | --- |
| Next hunk | `]h` |
| Previous hunk | `[h` |
| Preview hunk | `<leader>gp` |
| Stage hunk | `<leader>gs` |
| Reset hunk | `<leader>gr` |

For a full diff, use `<leader>gd`. For Git status, use `<leader>gg`.

## I Want to Focus and Reduce Visual Noise

| Goal | Use |
| --- | --- |
| Hide diagnostic virtual text | `<leader>lf` |
| Clear search highlight | `<Esc>` |
| Close other buffers | `<leader>bo` |
| Toggle file tree | `<leader>c` |
| Use fuzzy navigation instead of the tree | `<leader>sf`, `<leader>sg`, `<leader><leader>` |

## I Want to Replace Text Across Files

Use Spectre:

| Scope | Keymap |
| --- | --- |
| Toggle Spectre | `<leader>S` |
| Current word | `<leader>sW` |
| Visual selection | `<leader>sW` in visual mode |
| Current file | `<leader>sp` |

Review replacements before applying them.
