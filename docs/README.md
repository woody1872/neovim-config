# Neovim configuration documentation

This repository contains a modular Neovim configuration derived from
Kickstart.nvim. It provides Telescope search, language-server integration,
completion, formatting, Treesitter syntax support, and a file explorer.

## Documentation

- [Keymaps](keymaps.md): configured mappings, inherited defaults, modes, and examples.
- [Plugins](plugins.md): plugin declarations, enabled features, and package management.
- [Configuration](configuration.md): requirements, editor settings, language tools,
  formatting, and source-file organisation.

## Quick reference

**The leader key is Space.** `Space sf` means press Space, then `s`, then `f`.
Most shortcuts below start in normal mode: press Escape first if necessary.

| Task | Keys |
| --- | --- |
| Find a file | `Space sf` |
| Search project contents | `Space sg` |
| Switch open buffers | `Space Space` |
| Open recent files | `Space s.` |
| Search lines in this buffer | `Space /` |
| Browse files around the current file | `\` |
| Go to definition | `grd` |
| Find references | `grr` |
| Read hover documentation | `K` (built-in LSP behaviour) |
| Rename a symbol | `grn` |
| Request code actions | `gra` |
| Format | `Space f` |
| Accept a completion in insert mode | `Ctrl-y` |
| Search available keymaps | `Space sk` |

Which-key displays available mappings after a pause of approximately one second
following a prefix such as `Space s` or `gr`. Code-navigation actions require an
attached language server with the relevant capability.

## Basic workflow

1. Run `nvim` in the project directory. Telescope searches normally use Neovim's
   current working directory; `:pwd` shows it.
2. Use `Space sf` to open a file or `Space sg` to find text across the project.
3. Use `grd` to follow a definition and `Ctrl-o` to return to the previous location.
4. Use `Space Space` to switch files already open as buffers.
5. In insert mode, select a completion with `Ctrl-n` / `Ctrl-p`, then accept it
   with `Ctrl-y`.
6. Save with `:w`. Go, Python, and Lua are configured to format on save, subject
   to the required formatter or language server being available.

## Diagnostic commands

| Command | Purpose |
| --- | --- |
| `:Mason` | Inspect installed language servers and tools |
| `:ConformInfo` | Inspect formatter availability and formatting logs |
| `:checkhealth woody1872` | Check the Neovim version and required executables |
| `:checkhealth vim.lsp` | Check language-server configuration |
| `:checkhealth blink.cmp` | Check completion setup |
| `:verbose nmap <Space>sf` | See a normal-mode mapping and where it was defined |
| `:verbose imap <C-y>` | Inspect the insert-mode completion acceptance mapping |
| `:messages` | Review messages and errors |

Plugin defaults described in these guides correspond to the revisions recorded
in [nvim-pack-lock.json](../nvim-pack-lock.json). Updating plugins may change
inherited behaviour or mappings.
