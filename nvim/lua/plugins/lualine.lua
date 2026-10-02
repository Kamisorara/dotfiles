return {
  'nvim-lualine/lualine.nvim',
  -- UI 就绪后再加载，不占启动关键路径
  event = 'VeryLazy',
  config = function()
    require('lualine').setup {
      sections = {
        lualine_a = { 'mode' },
        -- diff 组件自动优先用 gitsigns 的数据
        lualine_b = { 'branch', 'diff', { 'filename', path = 3 } },
        lualine_c = { 'diagnostics' },
        lualine_x = {},
        lualine_y = { 'progress' },
        lualine_z = { 'location', 'filetype' },
      },
    }
  end,
}
