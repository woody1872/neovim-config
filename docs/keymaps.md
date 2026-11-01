# Keymap reference

[Documentation index](README.md)

## Notation and discovery

- Leader and local leader are both **Space**.
- `Space sf` is a sequence; `Ctrl-h` is a simultaneous key combination.
- Keys are case-sensitive: `grd` and `grD` do different things.
- Unless a mode or context is stated, start in normal mode.
- `Space sk` searches available mappings. Which-key shows prefix hints after
  about one second.

Each section identifies mappings defined by the configuration or inherited from
plugins and Neovim. Buffer-local and mode-specific mappings take precedence over
global mappings in their applicable context.

## Files and search: custom Telescope mappings

Source: [telescope.lua](../lua/woody1872/plugins/telescope.lua).

| Keys | Mode | Action |
| --- | --- | --- |
| `Space sf` | Normal | Find files from the current working directory |
| `Space st` | Normal | Find Git-tracked files |
| `Space sg` | Normal | Search project contents interactively |
| `Space sw` | Normal / Visual | Search the word under the cursor or the characterwise visual selection |
| `Space /` | Normal | Fuzzy-search current-buffer lines in a dropdown without a preview |
| `Space s/` | Normal | Search contents of open files |
| `Space Space` | Normal | Find and switch open buffers |
| `Space s.` | Normal | Browse recently opened files |
| `Space sr` | Normal | Resume the previous Telescope picker |
| `Space sd` | Normal | Search diagnostics |
| `Space sh` | Normal | Search help tags |
| `Space sk` | Normal | Search keymaps |
| `Space sc` | Normal | Search commands |
| `Space ss` | Normal | Browse Telescope's built-in pickers |
| `Space sn` | Normal | Find files in the Neovim configuration directory |

Project-content searches use `rg` (ripgrep). Standard picker and tool filtering
applies to hidden and ignored files.

### Inside a Telescope picker: plugin defaults

Pickers initially accept typing to filter results.

| Keys | Action |
| --- | --- |
| `Ctrl-n` / `Ctrl-p`, or Down / Up | Next / previous result |
| Enter | Select result |
| `Ctrl-v` | Open in a vertical split |
| `Ctrl-x` | Open in a horizontal split |
| `Ctrl-t` | Open in a tab |
| `Ctrl-u` / `Ctrl-d` | Scroll preview up / down |
| Tab / Shift-Tab | Toggle selection and move through results |
| `Ctrl-q` | Send results to the quickfix list and open it |
| `Ctrl-/` | Show picker mappings while typing |
| `Ctrl-c` | Close while typing |
| Escape | Enter normal mode; Escape again closes the picker |
| `j` / `k` | Next / previous result in picker normal mode |
| `?` | Show mappings in picker normal mode |

## Code navigation: custom mappings

Sources: [lsp.lua](../lua/woody1872/lsp.lua) and
[telescope.lua](../lua/woody1872/plugins/telescope.lua).

These are buffer-local mappings installed when a language server attaches.
Each action requires support from the attached server.

| Keys | Mode | Action |
| --- | --- | --- |
| `grd` | Normal | Go to definition through Telescope |
| `grD` | Normal | Go to declaration |
| `grr` | Normal | Find references through Telescope |
| `gri` | Normal | Find implementations through Telescope |
| `grt` | Normal | Find type definitions through Telescope |
| `grn` | Normal | Rename symbol |
| `gra` | Normal / Visual | Request code actions |
| `gO` | Normal | Search current-document symbols |
| `gW` | Normal | Search workspace symbols dynamically |
| `Space th` | Normal | Toggle inlay hints; mapped only if supported |

### Related Neovim defaults

The following mappings are provided by Neovim.

| Keys | Context | Action |
| --- | --- | --- |
| `K` | Normal, supported LSP buffer | Hover documentation |
| `Ctrl-s` | Insert, supported LSP buffer | Signature help |
| `[d` / `]d` | Normal | Previous / next diagnostic |
| `Ctrl-o` / `Ctrl-i` | Normal | Older / newer position in the jump list |
| `gcc` | Normal | Comment/uncomment the current line |
| `gc` | Visual | Comment/uncomment the selection |

## Formatting and diagnostics: custom mappings

Sources: [conform.lua](../lua/woody1872/plugins/conform.lua) and
[remap.lua](../lua/woody1872/remap.lua).

| Keys | Mode | Action |
| --- | --- | --- |
| `Space f` | Normal | Format the buffer asynchronously |
| `Space f` | Visual | Format the selection asynchronously, if supported |
| `Space q` | Normal | Populate and open the window's diagnostic location list |

`Space q` uses `vim.diagnostic.setloclist` to open the window's location list.
Use `:lnext` / `:lprev` to navigate it and `:lclose` to close it.

## Completion: Blink defaults

Source: [blink.lua](../lua/woody1872/plugins/blink.lua), which selects the
`default` keymap preset. These keys apply in insert mode.

| Keys | Action |
| --- | --- |
| `Ctrl-n` / `Ctrl-p`, or Down / Up | Select next / previous completion |
| `Ctrl-y` | Accept the selected completion, selecting one if needed |
| `Ctrl-e` | Cancel completion |
| `Ctrl-Space` | Open completion; show/hide completion documentation when applicable |
| `Ctrl-b` / `Ctrl-f` | Scroll completion documentation up / down |
| Tab / Shift-Tab | Jump forward / backward through active snippet placeholders |
| `Ctrl-k` | Show/hide signature help |

`Ctrl-y` accepts a completion. Tab navigates snippet placeholders, and Enter
retains its existing behaviour. Where no completion or snippet action applies,
the preset generally falls back to the key's existing behaviour.

## Windows, movement, and search: custom mappings

Source: [remap.lua](../lua/woody1872/remap.lua).

| Keys | Action |
| --- | --- |
| `Ctrl-h` | Focus the left split |
| `Ctrl-j` | Focus the lower split |
| `Ctrl-k` | Focus the upper split |
| `Ctrl-l` | Focus the right split |
| `Ctrl-u` / `Ctrl-d` | Scroll half a page, then centre the cursor |
| `n` / `N` | Next / previous search match, centre it, and open covering folds |
| `J` | Join the next line while preserving cursor position |
| Escape | Clear search highlighting |
| Left / Right / Up / Down | Show reminders to use `h` / `l` / `k` / `j` |

Create splits with the built-in `:split` / `:vsplit` commands or
`Ctrl-w s` / `Ctrl-w v` mappings.

## Surrounding text: mini.surround defaults

Source: [mini.lua](../lua/woody1872/plugins/mini.lua).

These mappings are entered directly, without the Space leader.

| Pattern | Action | Example |
| --- | --- | --- |
| `sa` + motion + surrounding | Add surrounding | `saiw"` wraps the current word in double quotes |
| `sa` + surrounding in Visual mode | Surround the selection | Select text, then `sa"` |
| `sd` + surrounding | Delete surrounding | `sd"` removes surrounding double quotes |
| `sr` + old + new surrounding | Replace surrounding | `sr"'` changes double quotes to single quotes |
| `sf` / `sF` + surrounding | Find surrounding right / left | `sf)` |
| `sh` + surrounding | Highlight surrounding | `sh)` |

The suffixes `l` and `n` select the previous/next search method, for example
`sdn)` to delete the next matching parenthesis surrounding. Surround searches
retain the plugin's default range of 20 lines.

## Text objects: mini.ai

Source: [mini.lua](../lua/woody1872/plugins/mini.lua). The module extends
**around/inside** text-object selection.

Use these after an operator such as `d` (delete), `c` (change), or `y` (yank),
or while selecting in Visual mode. Append a text-object identifier such as
`"` for quotes or `)` for parentheses.

| Prefix | Meaning | Origin |
| --- | --- | --- |
| `i` / `a` | Inside / around an object | Plugin defaults extending normal text objects |
| `ii` / `aa` | Inside / around the next object | Custom mappings replacing mini.ai's `in` / `an` |
| `il` / `al` | Inside / around the previous object | Plugin defaults |
| `g[` / `g]` + object identifier | Move to an object's left / right edge | Plugin defaults, Normal mode |

Examples: `ci"` changes inside quotes, `di)` deletes inside parentheses, and
`dii)` deletes inside the next parenthesis pair. The configured text-object
search range is **500 lines**. See `:help mini.ai` for additional objects.

## File explorer: Neo-tree

Source: [neo-tree.lua](../lua/woody1872/plugins/neo-tree.lua).

The custom normal-mode mapping `\` runs `:Neotree reveal`. Inside the filesystem
tree, `\` is remapped to close it. The remaining keys below are plugin defaults.

| Keys inside the tree | Action |
| --- | --- |
| Enter | Open a file or directory |
| Space | Expand/collapse a directory |
| `\` / `q` | Close tree |
| `a` / `A` | Add file / directory |
| `r` / `d` | Rename / delete |
| `y` / `x` / `p` | Copy / cut / paste |
| `c` / `m` | Copy / move to an entered destination |
| `s` / `S` | Open in a vertical / horizontal split |
| `t` | Open in a new tab |
| `P` | Toggle preview |
| `C` / `z` | Close node / all nodes |
| `R` | Refresh |
| `H` | Toggle hidden files |
| `/` | Fuzzy-find |
| Backspace | Navigate up a directory |
| `.` | Set selected directory as root |
| `[g` / `]g` | Previous / next Git-modified entry |
| `?` | Show help for tree mappings |

See [Neo-tree automatic closing](configuration.md#neo-tree-automatic-closing)
for the behaviour of the custom buffer-entry hook.

## Which-key groups

Which-key groups related mappings under `Space s` (Search), `Space t` (Toggle),
`Space h` (Git Hunk), and `gr` (LSP Actions). `Space h` is a group label with no
configured hunk actions. `Space t` contains the conditional `Space th`
inlay-hint mapping.
