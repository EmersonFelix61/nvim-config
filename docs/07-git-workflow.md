# Git Workflow

## What Is Configured

- `gitsigns.nvim`: signs, hunk navigation, hunk preview, stage/reset, blame, word diff.
- `diffview.nvim`: diff view and file/project history.
- `neogit`: Git status UI with integrations for Diffview and Telescope.

## See Modified Lines

Open any tracked file. Gitsigns adds signs in the sign column for added, changed, deleted, and top-deleted lines.

Use:

| Action | Keymap |
| --- | --- |
| Next hunk | `]h` |
| Previous hunk | `[h` |
| Preview hunk | `<leader>gp` |
| Toggle word diff | `<leader>gw` |

## Stage or Reset a Hunk

| Action | Keymap |
| --- | --- |
| Stage hunk | `<leader>gs` |
| Reset hunk | `<leader>gr` |
| Send hunks to quickfix | `<leader>gq` |

Use reset carefully. It discards the selected hunk.

## Blame

| Action | Keymap |
| --- | --- |
| Full blame for current line | `<leader>gb` |
| Toggle current-line blame | `<leader>gB` |

## Review Diffs

| Action | Keymap or command |
| --- | --- |
| Open project diff | `<leader>gd` or `:DiffviewOpen` |
| Close Diffview | `<leader>gD` or `:DiffviewClose` |
| Current file history | `<leader>gh` or `:DiffviewFileHistory %` |
| Project history | `<leader>gH` or `:DiffviewFileHistory` |

## Git Status UI

Use `<leader>gg` or `:Neogit` to open Neogit.

Recommended flow:

1. Review signs while editing.
2. Preview individual hunks with `<leader>gp`.
3. Stage simple hunks with `<leader>gs`.
4. Open `<leader>gg` when you want a broader Git status interface.
5. Use Diffview for larger reviews.
