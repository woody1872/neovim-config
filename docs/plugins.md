# Plugins and enabled features

[Documentation index](README.md)

## Package management

The configuration uses Neovim's built-in `vim.pack` for package management.
Plugin declarations live alongside their setup code.
[nvim-pack-lock.json](../nvim-pack-lock.json) records source URLs and revisions.

[pack.lua](../lua/woody1872/pack.lua) handles install/update build events:

- Builds Telescope's native FZF extension with `make` when available.
- Provides a LuaSnip `make install_jsregexp` build hook. LuaSnip is recorded in
  the lockfile but has no active package declaration.
- Runs `TSUpdate` for Treesitter changes.

Most declarations do not constrain a version. Blink is constrained to `1.*`,
Treesitter to `main`, and Neo-tree uses a wildcard version range.

## Declared plugins

The following plugins are declared by the configuration. The native FZF
extension is conditional on `make` availability; icon loading follows the
`have_nerd_font` setting.

| Plugin | Role and configured behaviour | Configuration source |
| --- | --- | --- |
| `telescope.nvim` | File/content search, buffer switching, diagnostics, symbols, help, and commands | [telescope.lua](../lua/woody1872/plugins/telescope.lua) |
| `telescope-fzf-native.nvim` | Native fuzzy sorting; declared when `make` is available, extension loading attempted | [telescope.lua](../lua/woody1872/plugins/telescope.lua) |
| `telescope-ui-select.nvim` | Uses Telescope dropdowns for `vim.ui.select` menus | [telescope.lua](../lua/woody1872/plugins/telescope.lua) |
| `neo-tree.nvim` | File explorer with `\` reveal/close mappings and a custom auto-close hook | [neo-tree.lua](../lua/woody1872/plugins/neo-tree.lua) |
| `nvim-lspconfig` | Server definitions used by Neovim's native LSP configuration | [lsp.lua](../lua/woody1872/lsp.lua) |
| `mason.nvim` | Installs and exposes language-server/tool executables | [lsp.lua](../lua/woody1872/lsp.lua) |
| `mason-tool-installer.nvim` | Ensures the five configured server/tool packages are installed | [lsp.lua](../lua/woody1872/lsp.lua) |
| `mason-lspconfig.nvim` | Mason/LSP integration package; loaded without an explicit `.setup()` call | [lsp.lua](../lua/woody1872/lsp.lua) |
| `blink.cmp` | LSP, path, and snippet completion; signature help; documentation after 250 ms; Lua fuzzy implementation | [blink.lua](../lua/woody1872/plugins/blink.lua) |
| `conform.nvim` | Manual formatting and format-on-save for Go, Python, and Lua; LSP formatting fallback | [conform.lua](../lua/woody1872/plugins/conform.lua) |
| `nvim-treesitter` | Parser installation, highlighting, and indentation where queries exist | [nvim-treesitter.lua](../lua/woody1872/plugins/nvim-treesitter.lua) |
| `mini.nvim` | Only `mini.ai`, `mini.surround`, and `mini.statusline` are enabled | [mini.lua](../lua/woody1872/plugins/mini.lua) |
| `gitsigns.nvim` | Git gutter signs: `+` additions, `~` changes, and deletion indicators; no custom action mappings | [gitsigns.lua](../lua/woody1872/plugins/gitsigns.lua) |
| `which-key.nvim` | Shortcut hints after 1,000 ms; Search, Toggle, Git Hunk, and LSP Actions groups | [which-key.lua](../lua/woody1872/plugins/which-key.lua) |
| `todo-comments.nvim` | Highlights TODO-style comments; gutter signs disabled; no custom shortcuts | [todo-comments.lua](../lua/woody1872/plugins/todo-comments.lua) |
| `guess-indent.nvim` | Detects indentation from existing files using default settings | [guess-indent.lua](../lua/woody1872/plugins/guess-indent.lua) |
| `fidget.nvim` | LSP progress notifications with default settings | [fidget.lua](../lua/woody1872/plugins/fidget.lua) |
| `tokyonight.nvim` | `tokyonight-night` colour scheme; comment italics disabled | [theme.lua](../lua/woody1872/theme.lua) |
| `nvim-web-devicons` | File icons; loaded because `have_nerd_font` is true | [nvim-web-devicons.lua](../lua/woody1872/plugins/nvim-web-devicons.lua) |
| `plenary.nvim` | Supporting library for Telescope and Neo-tree | [telescope.lua](../lua/woody1872/plugins/telescope.lua), [neo-tree.lua](../lua/woody1872/plugins/neo-tree.lua) |
| `nui.nvim` | UI library used by Neo-tree | [neo-tree.lua](../lua/woody1872/plugins/neo-tree.lua) |

## Additional lockfile entry

[nvim-pack-lock.json](../nvim-pack-lock.json) also contains `LuaSnip`. The
configuration has no active LuaSnip declaration or setup call, and Blink uses
its default snippet integration. The lockfile entry does not enable LuaSnip.

## Mini modules

- **mini.ai:** expanded text objects, a 500-line search range, and custom
  `aa` / `ii` prefixes for the next object.
- **mini.surround:** default `sa`, `sd`, `sr`, `sf`, `sF`, and `sh` mappings.
- **mini.statusline:** status line with icons and a configured line/column
  location section.

Installing the Mini package does not enable its other modules automatically.

## Treesitter languages

The configuration explicitly requests these parsers:

`bash`, `c`, `diff`, `html`, `lua`, `luadoc`, `markdown`, `markdown_inline`,
`query`, `vim`, `vimdoc`, `python`, and `go`.

On filetype detection, it also attempts to install and attach other available
parsers as needed. The set of installed parsers therefore depends on the filetypes
opened with the configuration.

Parser support provides syntax features independently of language servers.
For example, a JavaScript parser does not imply a configured JavaScript LSP.

## Completion and snippets

Blink uses sources `lsp`, `path`, and `snippets`, with its default snippet
integration. Buffer-word completion is not in the configured source list.
There is no active LuaSnip setup or snippet-collection plugin declaration.
See the [completion keys](keymaps.md#completion-blink-defaults) for the inherited
default keymap.
