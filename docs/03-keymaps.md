# Keymaps

Keymaps listed here were extracted from active configuration files. `<leader>` is `Space`.

## General

| Keymap | Mode | Action |
| --- | --- | --- |
| `<Esc>` | normal | Clear search highlight |
| `jk` | insert, visual, select | Leave to normal mode |
| `<leader>k` | normal | Open Which-key for `<leader>` |
| `<leader>gk` | normal | Open Which-key for `g` |
| `<leader>gz` | normal | Open Which-key for `z` |
| `<leader>li` | normal | Toggle keymap description language |

## Navigation and Files

| Keymap | Mode | Action |
| --- | --- | --- |
| `<C-h>` | normal | Focus left window |
| `<C-l>` | normal | Focus right window |
| `<C-j>` | normal | Focus lower window |
| `<C-k>` | normal | Focus upper window |
| `<leader>sf` | normal | Telescope: find files |
| `<leader>sg` | normal | Telescope: live grep |
| `<leader>sw` | normal | Telescope: grep word under cursor |
| `<leader>/` | normal | Telescope: search current buffer |
| `<leader><leader>` | normal | Telescope: buffers |
| `<leader>s.` | normal | Telescope: recent files |
| `<leader>sn` | normal | Telescope: files in this Neovim config |
| `<leader>sh` | normal | Telescope: help tags |
| `<leader>sk` | normal | Telescope: keymaps |
| `<leader>ss` | normal | Telescope: builtins |
| `<leader>sd` | normal | Telescope: diagnostics |
| `<leader>sr` | normal | Telescope: resume |
| `<leader>s/` | normal | Telescope: grep open files |
| `<leader>c` | normal | Neo-tree toggle reveal |
| `\` | normal | Neo-tree reveal |
| `<leader>j` | normal | mini.jump2d |
| `<leader>jw` | normal | mini.jump2d word start |
| `<leader>jc` | normal | mini.jump2d single character |
| `<leader>jl` | normal | mini.jump2d line start |

## Editing

| Keymap | Mode | Action |
| --- | --- | --- |
| `<A-h>` | visual, normal | mini.move left |
| `<A-l>` | visual, normal | mini.move right |
| `<A-j>` | visual, normal | mini.move down |
| `<A-k>` | visual, normal | mini.move up |
| `<leader>S` | normal | Toggle Spectre |
| `<leader>sW` | normal | Spectre with word under cursor |
| `<leader>sW` | visual | Spectre with selection |
| `<leader>sp` | normal | Spectre in current file |
| `<leader>f` | normal | Format buffer with Conform |

## Buffers

| Keymap | Mode | Action |
| --- | --- | --- |
| `<Tab>` | normal | Next buffer |
| `<S-Tab>` | normal | Previous buffer |
| `<leader>b.` | normal | Move buffer right |
| `<leader>b,` | normal | Move buffer left |
| `<leader>bd` | normal | Close buffer |
| `<leader>bo` | normal | Close other buffers |
| `<leader>br` | normal | Close buffers to the right |
| `<leader>bl` | normal | Close buffers to the left |
| `<leader>bp` | normal | Pick buffer |
| `<leader>bc` | normal | Pick buffer to close |
| `<leader>bP` | normal | Pin/unpin buffer |
| `<leader>bs` | normal | Order buffers by directory |
| `<leader>be` | normal | Order buffers by extension |

## LSP and Diagnostics

| Keymap | Mode | Action |
| --- | --- | --- |
| `gd` | normal | Go to definition |
| `gr` | normal | Show references |
| `gI` | normal | Go to implementation |
| `gD` | normal | Go to declaration |
| `<leader>D` | normal | Type definition |
| `<leader>ds` | normal | Document symbols |
| `<leader>ws` | normal | Workspace symbols |
| `<leader>rn` | normal | Rename symbol |
| `<leader>ca` | normal, visual | Code action |
| `<leader>le` | normal | Open line diagnostic |
| `<leader>lt` | normal | Enable virtual text |
| `<leader>lf` | normal | Disable virtual text |
| `<leader>q` | normal | Send diagnostics to the location list |

## Git

| Keymap | Mode | Action |
| --- | --- | --- |
| `]h` | normal | Next hunk |
| `[h` | normal | Previous hunk |
| `<leader>gp` | normal | Preview hunk |
| `<leader>gs` | normal | Stage hunk |
| `<leader>gr` | normal | Reset hunk |
| `<leader>gb` | normal | Blame current line |
| `<leader>gB` | normal | Toggle current-line blame |
| `<leader>gw` | normal | Toggle word diff |
| `<leader>gq` | normal | Send hunks to quickfix |
| `<leader>gd` | normal | Open Diffview |
| `<leader>gD` | normal | Close Diffview |
| `<leader>gh` | normal | Current file history |
| `<leader>gH` | normal | Project history |
| `<leader>gg` | normal | Open Neogit |

Found conflict-like area: `gr` and `<leader>gr` are different mappings. `gr` is LSP references; `<leader>gr` is Gitsigns reset hunk.

## Terminal

| Keymap | Mode | Action |
| --- | --- | --- |
| `<leader>tt` | normal | Toggle ToggleTerm |
| `<C-t>` | normal | Toggle ToggleTerm |
| `<C-t><C-t>` | terminal | Leave terminal mode and toggle ToggleTerm |
| `<Esc><Esc>` | terminal | Leave terminal insert mode |

## C/42

| Keymap | Mode | Action |
| --- | --- | --- |
| `<leader>n` | normal | Run Norminette |
| `<leader>ns` | normal | Norminette size action |
| `<F1>` | normal | Insert/update 42 header |

## Python

| Keymap | Mode | Action |
| --- | --- | --- |
| `<leader>8` | normal | Toggle visual Flake8 diagnostics |

Commands: `:Flake8Check` and `:Flake8Toggle`.

## Debug

| Keymap | Mode | Action |
| --- | --- | --- |
| `<F5>` | normal | Continue/start debug |
| `<F10>` | normal | Step over |
| `<F11>` | normal | Step into |
| `<F12>` | normal | Step out |
| `<leader>db` | normal | Toggle breakpoint |
| `<leader>du` | normal | Toggle DAP UI |

## UI

| Keymap | Mode | Action |
| --- | --- | --- |
| `<leader>k` | normal | Discover keymaps with Which-key |
| `<leader>sk` | normal | Search keymaps with Telescope |

Found issue: disabled arrow-key mappings exist as comments in `lua/config/keymaps.lua`. They are not active and are not documented as behavior.
