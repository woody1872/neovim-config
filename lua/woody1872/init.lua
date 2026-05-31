---@param repo string
---@return string
function GH(repo) return 'https://github.com/' .. repo end

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },

  virtual_text = true,
  virtual_lines = false,

  jump = {
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}

-- Core stuff
require 'woody1872.set'
require 'woody1872.remap'
require 'woody1872.pack'
require 'woody1872.lsp'
require 'woody1872.theme'

-- Plugins and plugin config
require 'woody1872.plugins.telescope'
require 'woody1872.plugins.guess-indent'
require 'woody1872.plugins.nvim-web-devicons'
require 'woody1872.plugins.gitsigns'
require 'woody1872.plugins.which-key'
require 'woody1872.plugins.todo-comments'
require 'woody1872.plugins.mini'
require 'woody1872.plugins.nvim-treesitter'
require 'woody1872.plugins.conform'
require 'woody1872.plugins.fidget'
require 'woody1872.plugins.blink'
require 'kickstart.plugins.neo-tree'
