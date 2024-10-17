return {
  'folke/which-key.nvim',
  version = 'v2.1.0',
  event = 'VeryLazy',
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = false,
      },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    window = {
      border = 'none',
      position = 'bottom',
      -- Leave 1 line at top / bottom for bufferline / lualine
      margin = { 1, 0, 1, 0 },
      padding = { 1, 0, 1, 0 },
      winblend = 0,
      zindex = 1000,
    },
  },
  config = function(_, opts)
    require('which-key').setup(opts)
    local wk = require 'which-key'
    wk.register {
      ['<leader>b'] = { name = '+buffer' },
      ['<leader>c'] = { name = '+comment' },
      ['<leader>g'] = { name = '+git' },
      ['<leader>h'] = { name = '+hop' },
      ['<leader>l'] = { name = '+lsp' },
      ['<leader>t'] = { name = '+telescope' },
      ['<leader>u'] = { name = '+utils' },
    }
  end,
}
