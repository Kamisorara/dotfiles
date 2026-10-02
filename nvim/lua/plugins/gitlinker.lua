-- gitlinker.nvim: 生成/打开当前行或选区在 git 托管站的永久链接
-- 用的是 ruifm/gitlinker.nvim 的维护 fork
return {
  'linrongbin16/gitlinker.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  cmd = 'GitLink',
  opts = {},
  keys = {
    {
      '<leader>gy',
      '<cmd>GitLink<cr>',
      mode = { 'n', 'x' },
      desc = 'yank git permalink',
      silent = true,
    },
    {
      '<leader>gY',
      '<cmd>GitLink!<cr>',
      mode = { 'n', 'x' },
      desc = 'open git permalink in browser',
      silent = true,
    },
  },
}
