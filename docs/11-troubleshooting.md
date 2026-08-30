# Troubleshooting

## Pyright Fails With `SyntaxError: Unexpected token '?'`

| Field | Details |
| --- | --- |
| Symptom | Pyright does not start and logs a JavaScript syntax error involving `?` |
| Likely cause | Neovim/Mason is running Pyright with an old Node.js, often Node 12 |
| Check | `:checkhealth kickoff42`, `:LspInfo`, `which node`, `node --version` |
| Next step | Ensure Neovim sees a modern Node.js. Node >= 18 is recommended; Node < 14 is an error for current Pyright. |

Also test:

```sh
~/.local/share/nvim/mason/bin/pyright-langserver --stdio
```

It should start without the `Unexpected token '?'` error.

## Node.js Differs Between Terminal and Neovim

| Field | Details |
| --- | --- |
| Symptom | `node --version` is modern in the shell, but Pyright fails inside Neovim |
| Likely cause | Neovim starts with a different `PATH` than the interactive shell |
| Check | `:checkhealth kickoff42` and `:lua print(vim.fn.exepath("node"))` |
| Next step | Fix the shell/session environment so Neovim receives the same modern Node.js path. |

Avoid reinstalling Pyright before confirming which Node.js is being used.

## Mason Installed a Tool, but the LSP Does Not Start

| Field | Details |
| --- | --- |
| Symptom | Tool appears in `:Mason`, but no LSP client appears in `:LspInfo` |
| Likely cause | Wrong filetype, server crash, missing runtime dependency, or PATH mismatch |
| Check | `:LspInfo`, `:Mason`, `:checkhealth kickoff42`, `:messages` |
| Next step | Open a file with the expected filetype and inspect the LSP log if it still fails. |

For Python, check both `pyright` and `ruff`. For C/C++, check `clangd`.

## `c_formatter_42` Is Missing

| Field | Details |
| --- | --- |
| Symptom | Formatting C with `<leader>f` fails or does nothing useful |
| Likely cause | `c_formatter_42` is not installed or not in `PATH` |
| Check | `which c_formatter_42`, `c_formatter_42 --help`, `:checkhealth kickoff42` |
| Next step | Install `c-formatter-42` through your Python tooling or add its script directory to `PATH`. |

```sh
python3 -m pip install --user c-formatter-42
```

## Norminette Is Missing

| Field | Details |
| --- | --- |
| Symptom | `<leader>n` cannot run Norminette |
| Likely cause | `norminette` is not installed or not in `PATH` |
| Check | `which norminette`, `norminette --version`, `:checkhealth kickoff42` |
| Next step | Install Norminette through your Python tooling or add its script directory to `PATH`. |

```sh
python3 -m pip install --user norminette
```

## Neovim in PATH Is Not the Target Version

| Field | Details |
| --- | --- |
| Symptom | `nvim --version` reports 0.12.x while the config targets 0.11.x |
| Likely cause | Another Neovim binary appears earlier in `PATH` |
| Check | `which nvim`, `nvim --version`, `:checkhealth kickoff42` |
| Next step | Use the project-installed Neovim 0.11.5 or adjust `PATH` deliberately. |

The config currently targets Neovim 0.11.x.

## Plugin Installed, but Command Does Not Exist

| Field | Details |
| --- | --- |
| Symptom | Running a plugin command gives `Not an editor command` |
| Likely cause | Plugin is lazy-loaded under a different event/command, not imported, failed to install, or the command name is wrong |
| Check | `:Lazy`, `:messages`, `:Telescope keymaps`, `:checkhealth` |
| Next step | Confirm the plugin is imported by `init.lua` and check the config file for declared `cmd` or `keys`. |

Do not document a command as part of the workflow unless it is configured or verified.

## Python Formatting Does Not Run Black/isort

| Field | Details |
| --- | --- |
| Symptom | Saving or pressing `<leader>f` does not run Black/isort on Python |
| Likely cause | Python formatters are installed but not configured in Conform |
| Check | `lua/plugins/lsp/formatting.lua`, `:ConformInfo` |
| Next step | Treat this as a found issue, not expected behavior, until configured. |

## Python Debugging Does Not Start

| Field | Details |
| --- | --- |
| Symptom | DAP works for C/C++ but not Python |
| Likely cause | No Python DAP configuration was found |
| Check | `lua/plugins/debug/dap.lua` |
| Next step | Implement Python DAP separately if needed. |
