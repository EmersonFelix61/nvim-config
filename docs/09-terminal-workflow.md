# Terminal Workflow

## What Is Configured

`toggleterm.nvim` provides a persistent integrated terminal.

Config file: `lua/plugins/utils/toggleterm.lua`.

## Keymaps and Command

| Action | Use |
| --- | --- |
| Toggle terminal | `<leader>tt` |
| Toggle terminal | `<C-t>` |
| Leave terminal mode and toggle terminal | `<C-t><C-t>` in terminal mode |
| Leave terminal insert mode | `<Esc><Esc>` in terminal mode |
| Toggle terminal command | `:ToggleTerm` |

The custom `:ToggleTerm` command opens a terminal associated with the current buffer directory when possible.

## Run Make

1. Open the project.
2. Press `<leader>tt`.
3. Run:

```sh
make
```

Keep the terminal open while editing, then run `make re`, `make clean`, or project-specific targets as needed.

## Run Python

```sh
python3 main.py
```

or:

```sh
python3 -m pytest
```

`pytest` is not configured as a Neovim plugin here. Run it from the terminal if the project uses it.

## Run Norminette

You can run Norminette through the plugin with `<leader>n`, or directly in the terminal:

```sh
norminette
```

## Stay Inside Neovim

Use the terminal for commands that do not need special editor integration:

- `make`
- `cc` / `clang`
- `python3`
- `pytest`
- `norminette`
- `black`
- `isort`
- `git`

This keeps compile/test/fix cycles inside one editor session.
