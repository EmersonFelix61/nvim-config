# UI and Focus

## Visual Plugins

| Plugin | What it changes |
| --- | --- |
| `tokyonight.nvim` | Default colorscheme |
| `catppuccin/nvim` and extra themes | Available alternative themes |
| `themery.nvim` | Theme selection support |
| `Switcheroo.nvim` | Theme switching support; verify manual usage |
| `noice.nvim` | Command/message UI |
| `nvim-notify` | Notification display used by Noice |
| `snacks.nvim` | Startup dashboard |
| `drop.nvim` | Visual effect |
| `indent-blankline.nvim` | Indentation guides |
| `mini.statusline` | Statusline |
| `barbar.nvim` | Bufferline |

There is no `lualine` configuration. The statusline is provided by `mini.statusline`.

## Functional UI

| Plugin | Why it matters |
| --- | --- |
| `which-key.nvim` | Helps discover mappings |
| `telescope.nvim` | Search UI for files, text, symbols, diagnostics, and keymaps |
| `neo-tree.nvim` | File tree |
| `dap-ui` | Debugging panels |
| `gitsigns.nvim` | Git signs and hunk actions |
| `diffview.nvim` | Git diff views |

## Discover Keymaps

Use:

| Action | Keymap |
| --- | --- |
| Show leader mappings | `<leader>k` |
| Search all keymaps | `<leader>sk` |
| Show `g` mappings | `<leader>gk` |
| Show `z` mappings | `<leader>gz` |

## Reduce Visual Noise

Use these when the screen gets too noisy:

| Goal | Use |
| --- | --- |
| Hide diagnostic virtual text | `<leader>lf` |
| Show diagnostic virtual text again | `<leader>lt` |
| Clear search highlight | `<Esc>` |
| Focus current file instead of tree | close Neo-tree with `<leader>c` or `\` behavior inside Neo-tree |
| Close extra buffers | `<leader>bo`, `<leader>br`, `<leader>bl` |

Found issue: some visual plugins are installed without local keymaps in this config. Their usage should be verified through their plugin commands or documentation before documenting a workflow around them.
