return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    win = {
      border = 'none',
      padding = { 1, 0, 1, 0 },
      wo = {
        winblend = 0,
      },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    -- v3 的写法是 wk.add + table spec（不再是 wk.register）
    wk.add {
      { '<leader>b', group = '+buffer' },
      { '<leader>c', group = '+comment' },
      { '<leader>g', group = '+git' },
      { '<leader>h', group = '+hop' },
      { '<leader>l', group = '+lsp' },
      { '<leader>t', group = '+telescope' },
      { '<leader>u', group = '+utils' },
    }
  end,
}
