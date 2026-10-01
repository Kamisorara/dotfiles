return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = { 'DiffviewOpen', 'DiffviewFileHistory', 'DiffviewClose' },
  keys = {
    {
      '<leader>go',
      ':DiffviewOpen<CR>',
      desc = 'diffview open',
      silent = true,
      noremap = true,
    },
    {
      '<leader>gq',
      ':DiffviewClose<CR>',
      desc = 'diffview close',
      silent = true,
      noremap = true,
    },
    {
      '<leader>gh',
      ':DiffviewFileHistory %<CR>',
      desc = 'file history',
      silent = true,
      noremap = true,
    },
    {
      '<leader>gH',
      ':DiffviewFileHistory<CR>',
      desc = 'repo history',
      silent = true,
      noremap = true,
    },
  },
  opts = {},
}
