-- flash.nvim: 替代 hop.nvim
-- 一个插件覆盖跳转 + treesitter 选择（补上 main 分支 treesitter
-- 移除 incremental selection 后的空缺）+ 远程编辑，键位沿用 <leader>hp
return {
  'folke/flash.nvim',
  version = '*',
  event = 'VeryLazy',
  opts = {},
  keys = {
    {
      '<leader>hp',
      function()
        require('flash').jump()
      end,
      desc = 'flash jump',
    },
    {
      '<leader>hs',
      function()
        require('flash').treesitter()
      end,
      desc = 'flash treesitter select',
    },
  },
}
