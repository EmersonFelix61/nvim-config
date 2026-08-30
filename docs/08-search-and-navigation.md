# Search and Navigation

## Telescope

Telescope is the main search interface.

| Goal | Keymap |
| --- | --- |
| Find files | `<leader>sf` |
| Search text in the project | `<leader>sg` |
| Search word under cursor | `<leader>sw` |
| Search in current buffer | `<leader>/` |
| Switch buffers | `<leader><leader>` |
| Search help | `<leader>sh` |
| Search keymaps | `<leader>sk` |
| Search diagnostics | `<leader>sd` |
| Resume last picker | `<leader>sr` |
| Search recent files | `<leader>s.` |
| Search open files | `<leader>s/` |
| Search config files | `<leader>sn` |

`<leader>sg` and `<leader>sw` require `ripgrep` (`rg`). If they do nothing or warn, check `rg --version`.

## Neo-tree

Neo-tree is the file explorer.

| Goal | Keymap |
| --- | --- |
| Reveal current file in tree | `\` |
| Toggle/reveal tree | `<leader>c` |

The tree is configured on the right side with width `33`.

## mini.jump2d

Use mini.jump2d when you can see where you want to go on screen.

| Goal | Keymap |
| --- | --- |
| General jump | `<leader>j` |
| Jump to word start | `<leader>jw` |
| Jump to character | `<leader>jc` |
| Jump to line start | `<leader>jl` |

## LSP Navigation

| Goal | Keymap |
| --- | --- |
| Go to definition | `gd` |
| Find references | `gr` |
| Go to implementation | `gI` |
| Go to declaration | `gD` |
| Type definition | `<leader>D` |
| Document symbols | `<leader>ds` |
| Workspace symbols | `<leader>ws` |

## Buffer Navigation

| Goal | Keymap |
| --- | --- |
| Next buffer | `<Tab>` |
| Previous buffer | `<S-Tab>` |
| Pick buffer | `<leader>bp` |
| Close buffer | `<leader>bd` |
| Close other buffers | `<leader>bo` |
