# kickoff42.nvim

`kickoff42.nvim` is an opinionated Neovim configuration focused on 42 School, C, Python, terminal-driven workflows, LSP, linting, formatting, and debugging.

This project is not meant to be a universal Neovim distribution. It is meant to be practical, predictable, and easy to inspect while working on code, navigating projects, reading diagnostics, formatting, debugging, and using Git without leaving the editor.

The repository started as a personal configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim). The original reference files are kept in `kickstart_files/`.

## Manual

- [Start here](docs/00-start-here.md)
- [Installation](docs/01-installation.md)
- [Plugin map](docs/02-plugin-map.md)
- [Keymaps](docs/03-keymaps.md)
- [Python workflow](docs/04-python-workflow.md)
- [C/42 workflow](docs/05-c-42-workflow.md)
- [Debugging](docs/06-debugging.md)
- [Git workflow](docs/07-git-workflow.md)
- [Search and navigation](docs/08-search-and-navigation.md)
- [Terminal workflow](docs/09-terminal-workflow.md)
- [UI and focus](docs/10-ui-and-focus.md)
- [Troubleshooting](docs/11-troubleshooting.md)
- [Plugin recipes](docs/12-plugin-recipes.md)

## Repository Layout

- `init.lua`: starts `lazy.nvim` and lists the active plugin modules explicitly.
- `lua/config/`: global options, keymaps, autocmds, highlights, and translations.
- `lua/plugins/`: active plugin specifications and configuration.
- `lua/kickoff42/`: project-specific logic, healthchecks, and integrations.
- `install-linux.sh`, `install-no-sudo.sh`, `install-windows.ps1`: installation scripts.

If the config is already installed and you want to learn how to use it, start with [docs/00-start-here.md](docs/00-start-here.md).
