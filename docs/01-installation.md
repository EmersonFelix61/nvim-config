# Installation

## Compatibility

- Neovim 0.11.x. The portable installer uses Neovim 0.11.5.
- Linux x86_64 or arm64 for tools installed by `install-no-sudo.sh`.
- Windows with PowerShell and user-installed dependencies.
- A modern Node.js for Pyright. Node >= 18 is recommended; Node < 14 breaks current Pyright releases.

Neovim 0.12 is not the declared target of this configuration. If the `nvim` in `PATH` points to 0.12.x, see [Troubleshooting](11-troubleshooting.md).

## Main Dependencies

- `git`, `curl`, `tar`, `gzip`, `xz`, `unzip`
- `make` and a C compiler
- `node` and `npm`
- `python3`
- `ripgrep` (`rg`)
- `fd` or `fdfind`
- Neovim 0.11.x

Useful 42 dependencies:

```sh
python3 -m pip install --user c-formatter-42
python3 -m pip install --user norminette
```

On distributions with PEP 668, you may need `pipx`, a virtual environment, or the Python packaging flow recommended by the distribution.

## Full Linux Installation

```sh
git clone --branch main https://github.com/EmersonFelix61/nvim-config /tmp/nvim-config
sh /tmp/nvim-config/install-linux.sh
```

The installer moves an existing Neovim config to a backup directory before installing the new one.

## No-sudo / 42 Environment Installation

```sh
git clone --branch main https://github.com/EmersonFelix61/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
cd "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
./install-no-sudo.sh
```

`install-no-sudo.sh` installs local tools under `~/.local`, restores plugin revisions from `lazy-lock.json`, and validates boot. It does not clone, move, or replace the config.

The Linux and Windows installers use `Lazy restore`, not `Lazy sync`: missing plugins are installed by Lazy at startup using the lockfile, and existing plugins are restored to the locked revisions. Installation does not intentionally update plugins to newer revisions or clean unrelated plugin directories.

## Windows Installation

```powershell
git clone --branch main https://github.com/EmersonFelix61/nvim-config "$env:TEMP\nvim-config"
& "$env:TEMP\nvim-config\install-windows.ps1"
```

The script prints `winget` commands for missing dependencies and installs the config into `$env:LOCALAPPDATA\nvim`.

## After Installing

Inside Neovim:

| Command | Use |
| --- | --- |
| `:Lazy` | Inspect plugins |
| `:Mason` | Inspect LSPs, linters, formatters, and debuggers |
| `:checkhealth kickoff42` | Validate the config environment |
| `:LspInfo` | See active LSP clients for the current buffer |
| `:Idioma toggle` | Toggle PT-BR/English keymap descriptions |

If another user adopts this config, update `user` and `mail` in `lua/plugins/42/header.lua`.
