# Configuration and language tools

[Documentation index](README.md)

## Requirements

The configuration requires **Neovim 0.12 or later** and uses the built-in
`vim.pack` and native LSP configuration APIs.

| Dependency | Purpose |
| --- | --- |
| `git` | Plugin repository operations and Git integration |
| `rg` (ripgrep) | Telescope content searches |
| `make` | Build the optional Telescope native FZF extension |
| `unzip` | Tool installation; included in the configuration's health checks |
| Go toolchain | Supplies `gofmt` for Go formatting |
| `ruff` | Python fixes, import organisation, and formatting |
| Nerd Font | Display icons with the enabled `have_nerd_font` setting |
| Clipboard provider | Support the `unnamedplus` system clipboard setting |

Language servers and StyLua are requested through Mason. Ruff is configured in
Conform separately and must be available to it, for example through a project
environment or `PATH`. See `:ConformInfo` for formatter resolution.

## Source-file map

| File | Responsibility |
| --- | --- |
| [init.lua](../init.lua) | Loads the `woody1872` module |
| [woody1872/init.lua](../lua/woody1872/init.lua) | Startup sequence, diagnostic display, yank highlighting, module loading |
| [set.lua](../lua/woody1872/set.lua) | Editor options, leader keys, Nerd Font flag |
| [remap.lua](../lua/woody1872/remap.lua) | Core custom mappings |
| [pack.lua](../lua/woody1872/pack.lua) | Plugin install/update build hooks |
| [lsp.lua](../lua/woody1872/lsp.lua) | Language servers, Mason, attach-time actions |
| [theme.lua](../lua/woody1872/theme.lua) | Tokyo Night theme |
| [plugins/](../lua/woody1872/plugins/) | Plugin declarations and individual setup |
| [health.lua](../lua/woody1872/health.lua) | `:checkhealth woody1872` |
| [nvim-pack-lock.json](../nvim-pack-lock.json) | Plugin source URLs and locked revisions |
| [.stylua.toml](../.stylua.toml) | Formatting rules for this repository's Lua |

Startup enables Lua module caching, then loads options, mappings, package hooks,
LSP configuration, the theme, and the individual plugin modules.

## Editor behaviour

Source: [set.lua](../lua/woody1872/set.lua).

| Area | Configured behaviour |
| --- | --- |
| Leader keys | Space for both leader and local leader |
| Line numbers | Absolute current-line number plus relative surrounding numbers |
| Indentation defaults | Tab stop, shift width, and soft tab stop are 4; `expandtab = false` means real tabs |
| Indentation detection | Guess-indent can override defaults for a file |
| Mouse | Enabled in all modes |
| Mode display | Built-in mode message disabled; Mini provides the status line |
| Clipboard | Scheduled `unnamedplus` setting connects ordinary copy/delete/paste registers to the system clipboard, subject to provider availability |
| Wrapped lines | Preserve indentation visually with `breakindent` |
| Undo | Persistent undo files enabled |
| Search | Ignore case unless the pattern contains uppercase characters |
| Sign column | Always visible |
| Update interval | 250 ms; affects idle events such as reference highlighting |
| Mapping timeout | 300 ms for mapped sequences |
| Which-key delay | Separately configured to 1,000 ms |
| Splits | New vertical splits open right; horizontal splits open below |
| Visible whitespace | Tabs shown as `» `, trailing spaces as `·`, nonbreaking spaces as `␣` |
| Substitution | Live `:substitute` preview in a split |
| Cursor | Current line highlighted; scroll margin of 10 lines where possible |
| Unsaved changes | Request confirmation when an operation would otherwise fail due to unsaved edits |
| Icons | `have_nerd_font = true`; expects an appropriate terminal font |

Copied text briefly highlights through a `TextYankPost` autocmd.

The four-column tab default is distinct from this repository's StyLua rules:
StyLua formats these Lua files with **two spaces**.

## Language servers and installation

Source: [lsp.lua](../lua/woody1872/lsp.lua).

| Language | Enabled server name | Mason package / executable |
| --- | --- | --- |
| Go | `gopls` | `gopls` |
| Python | `pyright` | `pyright`, including `pyright-langserver` |
| Rust | `rust_analyzer` | `rust-analyzer` |
| Lua | `lua_ls` | `lua-language-server` |
| Lua formatting | `stylua` | `stylua --lsp` |

Mason manages tool installation, and mason-tool-installer requests all five
configured server/tool packages. Each server is configured and enabled directly
through `vim.lsp.config` and `vim.lsp.enable`. Server attachment depends on
filetype matching, project-root detection, and executable availability.

Lua language-server settings target LuaJIT and include Neovim runtime libraries,
plus luv and busted library paths. For other projects with their own
`.luarc.json` or `.luarc.jsonc`, the extra runtime/workspace settings are skipped.
Formatting is disabled in `lua_ls` so StyLua handles it instead.

Language-server coverage is defined by the table above. Python's Ruff actions
run as Conform formatter steps.

## Formatting

Source: [conform.lua](../lua/woody1872/plugins/conform.lua).

`Space f` requests asynchronous formatting of the current buffer or visual
selection. Conform falls back to attached LSP formatting when no external
formatter is available for that filetype.

| Filetype | Formatting route | On save? |
| --- | --- | --- |
| Go | `gofmt` | Yes |
| Python | `ruff_fix`, then `ruff_organize_imports`, then `ruff_format` | Yes |
| Lua | LSP fallback to StyLua's language server; no direct Conform Lua formatter entry | Yes |
| Rust | LSP fallback if formatting is supported and available | No |
| Other | LSP fallback if formatting is supported and available | No |

Save-time formatting has a **500 ms timeout**. Formatting error notifications
are disabled. `:ConformInfo` reports formatter availability and formatting logs.

Lua formatting depends on the StyLua server attaching. Its LSP
definition uses `.stylua.toml`, `stylua.toml`, or `.editorconfig` as root markers.

The repository's [.stylua.toml](../.stylua.toml) specifies:

- Two-space indentation and Unix line endings.
- Preferred single quotes, with a target column width of 160.
- Omitted parentheses for supported single-argument calls.
- Collapsing simple statements where possible.

These formatting rules apply to this repository. Other projects can supply
their own StyLua configuration.

## Diagnostics and reference highlighting

Sources: [woody1872/init.lua](../lua/woody1872/init.lua) and
[lsp.lua](../lua/woody1872/lsp.lua).

- Diagnostics do not update while typing in insert mode.
- Diagnostics are sorted by severity.
- Inline virtual text is enabled; virtual lines are disabled.
- Warnings and errors are underlined.
- Floating diagnostic windows have rounded borders and show the source when
  multiple sources are involved.
- Diagnostic jumps open an explanation at the cursor without focusing it.
- When supported, pausing over a symbol highlights its references; moving clears
  those highlights.
- Inlay hints have a conditional `Space th` toggle rather than an explicit
  startup enable setting.

## Behaviour notes

### Python formatter dependency

Conform's three Python formatter steps use the `ruff` executable. Ruff is not
included in Mason's installation list. Make it available to Conform before
using Python format-on-save, and check resolution with `:ConformInfo`.

### Neo-tree automatic closing

The custom `BufEnter` callback retrieves the filesystem state and issues
`Neotree close` whenever a state is returned. Neo-tree's state manager creates
a state if necessary. The callback applies to every buffer entry, including
entries into the tree, so it can close the tree before a file is selected.

### Git-hunk mapping group

Which-key defines a `Space h` group. Gitsigns configures gutter signs but no
custom hunk navigation, staging, reset, preview, or blame mappings.

### Diagnostic location list

The `Space q` mapping's description mentions quickfix, but its implementation
calls `vim.diagnostic.setloclist`. Use location-list commands such as `:lnext`
and `:lprev` for those results.

## Version and health checks

The custom health check validates the minimum Neovim version and checks for
`git`, `make`, `unzip`, and `rg`.

Run `:checkhealth woody1872` for these checks, `:Mason` for tool packages,
and `:ConformInfo` for formatters. These checks address different parts of the
setup; the custom health check alone does not validate every plugin or server.
