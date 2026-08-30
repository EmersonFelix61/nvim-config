# Start Here

Do not try to memorize every keymap at once. Learn the config by workflows: open a project, find files, edit, read diagnostics, format, run a terminal, debug, and review Git changes.

The `<leader>` key is `Space`.

## Basic Flow

1. Open a project with `nvim .`.
2. Use `<leader>sf` to find files.
3. Use `<leader>sg` to search text in the project.
4. Edit normally. Use `jk` to leave insert mode.
5. Read diagnostics with `<leader>le` or open the diagnostics list with `<leader>q`.
6. Format with `<leader>f` when a formatter is configured for the filetype.
7. Open a terminal with `<leader>tt` or `<C-t>`.
8. Use Git through Gitsigns, Diffview, or Neogit.
9. Use DAP for C/C++ when `codelldb` is installed.

## I Want To / I Use

| I want to | Use |
| --- | --- |
| Find a file | `<leader>sf` |
| Search text in the project | `<leader>sg` |
| Search text in the current file | `<leader>/` |
| Switch buffers | `<leader><leader>` |
| Open the file explorer | `<leader>c` or `\` |
| See the diagnostic under the cursor | `<leader>le` |
| Open the diagnostics list | `<leader>q` |
| Rename a symbol with LSP | `<leader>rn` |
| Go to definition | `gd` |
| Find references | `gr` |
| Format the buffer | `<leader>f` |
| Open a terminal | `<leader>tt` or `<C-t>` |
| Run Norminette | `<leader>n` |
| Toggle visual Flake8 diagnostics | `<leader>8` |
| Open Neogit status | `<leader>gg` |
| Open project diff | `<leader>gd` |
| Start debugging | `<F5>` |
| Toggle breakpoint | `<leader>db` |
| Discover keymaps | `<leader>k` or `<leader>sk` |

## Learn Gradually

Start with Telescope, diagnostics, terminal, and Git. Then add LSP actions, DAP, Norminette, visual Flake8, and the more specific recipes.

When you forget a keymap, use `<leader>sk` to search keymaps with Telescope or `<leader>k` to open Which-key.
