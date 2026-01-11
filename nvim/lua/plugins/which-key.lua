return {
  'folke/which-key.nvim',
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
    win = {
      border = 'none',
      position = 'bottom',
      padding = { 1, 0, 1, 0 },
      wo = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.add {
      { '<leader>b', group = '+buffer' },
      { '<leader>c', group = '+comment' },
      { '<leader>g', group = '+git' },
      { '<leader>h', group = '+hop' },
      { '<leader>j', group = '+copilot' },
      { '<leader>l', group = '+lsp' },
      { '<leader>t', group = '+telescope' },
      { '<leader>u', group = '+utils' },
    }
  end,
}
