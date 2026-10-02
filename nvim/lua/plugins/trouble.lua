-- trouble.nvim: 工作区级诊断/符号/quickfix 列表
-- 与 lspsaga 的单行诊断（<leader>ln/lp）互补，注意 <leader>x 已被
-- keymap.lua 用作 quit+save，所以用 <leader>d 前缀
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  opts = {},
  keys = {
    {
      '<leader>dd',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'workspace diagnostics',
      silent = true,
    },
    {
      '<leader>db',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'buffer diagnostics',
      silent = true,
    },
    {
      '<leader>dS',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'symbols',
      silent = true,
    },
    {
      '<leader>dl',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'loclist',
      silent = true,
    },
    {
      '<leader>dq',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'quickfix',
      silent = true,
    },
  },
}
