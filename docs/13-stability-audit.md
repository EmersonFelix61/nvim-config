# Stability Audit - 2026-09-07

## Initial Findings

The audit started with read-only inspection of Git status/diffs, imports, plugin configuration, installed tools, logs, and controlled startup. Initial user changes were present in `init.lua`, `lazy-lock.json`, and `lua/plugins/fun/drop.lua`.

- Autopairs was no longer imported, was absent from the installed plugin directory, and had lost its lockfile entry. Its setup file was intact.
- Ruff 0.16.3's CLI reported default settings, but enabled substantially more rules than the intended study workflow. A real study file produced EXE001, I001, F401, and FURB105. No applicable Ruff configuration was found in the inspected global locations or that project's ancestors. Another project's independent `pyproject.toml` was left untouched.
- Global diagnostics had no explicit policy. On the tested Neovim, virtual text was already off, but severity sorting was off too. Norminette has its own inline diagnostic namespace.
- Pyright used basic checking across the workspace. Node 22 was active and Pyright started successfully. The installed Pyright package declares Node >= 14, and the custom healthcheck already validates Node versions.
- The Node helper could select a newer executable but leave an older one first in PATH when both directories were already present.
- Python formatters were installed but commented out in Conform. C's formatter was unavailable. Saving C did not fail.
- Flake8 started disabled and its commands existed, but in-flight results returned after disabling it and repopulated diagnostics.
- clangd's fallback flags were assigned to config after Neovim had constructed its initialization parameters, so those flags did not reach the server through the native 0.11 setup.
- Standalone Ruff/LuaLS files exposed missing-workspace warnings/errors. The LSP log was about 207 MB, largely normal clangd stderr traffic recorded as errors.
- The installers claimed to follow the lockfile but invoked `Lazy sync`, which also updates and cleans plugins.

## Changes by File

| File | Change and purpose |
| --- | --- |
| `init.lua` | Restored the existing autopairs import. This now matches Git HEAD, so it does not appear in the final diff. |
| `lazy-lock.json` | Restored only autopairs commit `430522f95fe4fb7c511ec64f8c1a90cc6a66c05c` relative to the initial worktree. All pre-existing version changes were preserved. |
| `lua/config/options.lua` | Explicit quiet diagnostics: no virtual text/lines, signs and underlines enabled, no Insert-mode updates, severity sorting, bordered floats. |
| `lua/plugins/lsp/lspconfig.lua` | Explicit Ruff E4/E7/E9/F defaults with project precedence, Pyright open-files diagnostics, standalone Ruff/LuaLS workspace fallback, legacy lspconfig require only in the legacy branch. |
| `lua/kickoff42/node.lua` | Moves the selected modern Node directory to the front of PATH without accumulating duplicate entries. |
| `lua/kickoff42/clangd.lua` | Sends fallback flags through `initializationOptions`; limits server stderr logging to errors. |
| `lua/kickoff42/flake8.lua` | Invalidates checks started before disabling Flake8, preserving explicit checks while automatic checks are off. |
| `lua/plugins/lsp/formatting.lua` | Disables automatic formatting for all filetypes, as requested. Keeps manual `<leader>f`; wires Python to isort/Black and uses Conform's temporary-file support for isort 8 with unsaved files. |
| `install-no-sudo.sh` | Uses `Lazy restore` instead of `Lazy sync` during validation. |
| `install-windows.ps1` | Makes the same lockfile restoration correction. |
| `docs/01-installation.md` | Documents lockfile restoration rather than plugin updates. |
| `docs/02-plugin-map.md` | Documents manual-only Conform and the Python formatter sequence. |
| `docs/04-python-workflow.md` | Documents manual formatting, quiet diagnostics, Ruff project settings, and Flake8 behavior. |
| `docs/11-troubleshooting.md` | Documents restored autopairs, PATH selection, standalone workspaces, missing C formatter, and diagnostic controls. |
| `docs/12-plugin-recipes.md` | Corrects the Python formatting workflow. |
| `docs/13-stability-audit.md` | Records findings, validation, and remaining limitations. |

Autopairs alone was reinstalled into the existing Lazy directory at its original locked revision. No mass update, sync, clean, commit, or push was performed. The user's change in `drop.lua` was preserved.

## Validation

The target binary was `~/.local/lib/kickoff42/nvim-0.11.5-x86_64/bin/nvim`. Initial controlled startup disabled automatic installation and tool checks through a temporary command-line wrapper. Sandbox EPERM errors were distinguished from real startup failures by rerunning with approved access. Final startup and LSP tests used the actual configuration.

Commands executed included:

```sh
git status --short
git diff --stat
git diff
git diff --check
nvim --version
node --version
python3 --version
npm --version
rg --version
git --version
norminette --version
bash -n install-linux.sh install-no-sudo.sh
sh -n install-linux.sh install-no-sudo.sh
~/.local/share/nvim/mason/bin/stylua --check init.lua lua/config/options.lua lua/kickoff42/node.lua lua/kickoff42/flake8.lua lua/kickoff42/clangd.lua lua/plugins/lsp/lspconfig.lua lua/plugins/lsp/formatting.lua
~/.local/lib/kickoff42/nvim-0.11.5-x86_64/bin/nvim --headless -i NONE '+checkhealth' +qa
~/.local/lib/kickoff42/nvim-0.11.5-x86_64/bin/nvim --headless -i NONE '+checkhealth kickoff42 noice vim.lsp' +qa
~/.local/lib/kickoff42/nvim-0.11.5-x86_64/bin/nvim --headless -i NONE '+luafile /tmp/kickoff42-final-lsp.lua'
~/.local/lib/kickoff42/nvim-0.11.5-x86_64/bin/nvim --headless -i NONE '+luafile /tmp/kickoff42-no-autoformat.lua'
```

The Lua scripts are session-local test artifacts in `/tmp`, not repository dependencies. Additional temporary scripts tested completion, Node ordering, Flake8 races, project Ruff settings, formatting, and Norminette. `:messages` was collected during startup and functional tests. The final focused health output is `/tmp/kickoff42-final-health.txt`.

Confirmed results:

- Neovim 0.11.5 boots without startup errors; all Lua modules compile and all literal i18n keys checked resolve in PT-BR and English, including mini.jump2d.
- Autopairs is loaded and typed `(`, `"`, and `[` produce matching pairs. Real `<C-y>` completion through cmp/LuaSnip produces `audit_call(value)` without duplicate parentheses. The existing configuration needs no additional cmp confirmation hook.
- Python attaches exactly one Pyright and one Ruff client; C attaches clangd; Lua attaches lua_ls. All advertise snippet completion support. Standalone Ruff and LuaLS resolve the tested directory as their root.
- The Python fixture retains F401/F821 and Pyright's undefined-variable error, without docstring, annotation, print, or FURB noise. An explicit project Ruff configuration overrides the editor defaults.
- Flake8 starts off, manual checks work, and disabling it prevents late diagnostics. Norminette can be enabled, runs against a C fixture, and clears diagnostics when disabled.
- Node 12 before Node 22 in PATH is corrected to Node 22; repeating selection is stable. clangd initialization parameters contain the configured fallback flags.
- Manual Python formatting works, including the isort 8 unsaved-file case. Python, Lua, and C saves preserve unformatted content; saving still does not format after Conform has been loaded. `<leader>f` remains functional.
- C saving works without `c_formatter_42`. The codelldb DAP adapter resolves to its installed Mason executable; a full debug session was not run.
- C/Python/Lua parsers work. Highlight queries for C, Python, Lua, Vim, and Markdown pass on both the installed 0.11.5 and 0.12.1 runtimes. Historical Noice query errors were not reproduced in these checks.

## Remaining Environment Issues and Limits

- Bare `nvim` still resolves to `/home/emda-sil/bin/nvim-dist/usr/bin/nvim` (0.12.1). The supported 0.11.5 is available through `~/.local/bin/nvim`. Shell configuration was not changed; launch that binary or adjust PATH deliberately.
- `c_formatter_42` remains absent. Its installation is documented; automatic formatting is disabled and saving is unaffected.
- Noice's optional `regex` parser is missing. The existing LSP log remains large; logs were not deleted. clangd 22 also emits a deprecation notice about lspconfig's offsetEncoding capability; this did not prevent initialization.
- The full healthcheck includes optional provider, LuaRocks, and inactive Snacks feature warnings. The extra `site/pack/core/opt` directory is empty. No competing plugin installation was found there.
- Installed versions checked: Node 22.23.1, Python 3.10.12, npm 10.9.8, Git 2.34.1, ripgrep 15.2.0, Pyright 1.1.412, Ruff 0.16.3, Black 26.5.1, isort 8.0.1, StyLua 2.5.2, clangd 22.1.6, LuaLS 3.19.1, Flake8 7.3.0, Norminette 3.3.59.
- Full installation/rollback and Windows execution were not run. `pwsh` is unavailable; the PowerShell change was reviewed statically. There is no `install.sh`. The lockfile behavior was verified against the installed Lazy implementation rather than restoring unrelated local plugin revisions during the audit.
- Tests were headless; interactive Noice rendering, every navigation key, and a full DAP session were not exhaustively exercised. Python DAP remains outside this correction.
- Pyright and Ruff can both report undefined variables; optional Flake8 can overlap with Ruff when explicitly enabled. They remain separate diagnostic sources, with no global suppression of real errors.

Existing keymaps, manual completion policy, plugin choices, 42 Header behavior, terminal workflow, translation system, and installer backup/cleanup structure were preserved. No new framework or plugin was added.
