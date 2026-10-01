return {
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- 打开文件才加载；dashboard 阶段按键触发加载
  event = { 'BufReadPost', 'BufNewFile' },
  keys = {
    -- 不用裸 <leader>t：它同时是 telescope 组前缀，直接映射会造成 timeoutlen 等待
    {
      '<leader>tt',
      '<cmd>TodoTelescope<cr>',
      desc = 'search todo comments',
      silent = true,
    },
    {
      ']t',
      function()
        require('todo-comments').jump_next()
      end,
      desc = 'Next todo comment',
    },
    {
      '[t',
      function()
        require('todo-comments').jump_prev()
      end,
      desc = 'Previous todo comment',
    },
  },
  opts = {},
}
