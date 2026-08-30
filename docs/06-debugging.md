# Debugging

## Plugins

- `nvim-dap`: Debug Adapter Protocol core.
- `nvim-dap-ui`: variables, scopes, stacks, and console panels.
- `nvim-dap-virtual-text`: inline runtime values.

Config file: `lua/plugins/debug/dap.lua`.

## Keymaps

| Keymap | Action |
| --- | --- |
| `<F5>` | Continue/start |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |
| `<leader>db` | Toggle breakpoint |
| `<leader>du` | Toggle DAP UI |

## Mental Model

1. Put a breakpoint where you want execution to stop.
2. Start or continue with `<F5>`.
3. Use `<F10>` to step over a call.
4. Use `<F11>` to step into a function.
5. Use `<F12>` to step out of a function.
6. Open the UI with `<leader>du` to inspect variables and stack.
7. Stop or restart through DAP commands. Verify: no dedicated stop/restart keymaps were found.

## C/C++

C and C++ are configured with `codelldb`.

Before debugging:

```sh
make
```

or compile with symbols:

```sh
cc -g main.c -o main
```

Then:

1. Open the file.
2. Set a breakpoint with `<leader>db`.
3. Press `<F5>`.
4. Enter the executable path when prompted.

If `codelldb` is missing, the config should notify you when the debugger is loaded.

## Python

Pending/verify: no Python DAP configuration was found. Pyright and Ruff are configured for LSP/linting, but that does not mean Python debugging is available.
