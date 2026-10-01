return {
  { 'NvChad/nvim-colorizer.lua', enabled = false },
  {
    'brenoprata10/nvim-highlight-colors',
    cmd = 'HighlightColors',
    -- 只在可能出现颜色值的文件类型里加载，代替 VeryLazy
    ft = {
      'css',
      'scss',
      'html',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
      'vue',
      'lua',
      'json',
    },
    opts = {
      enabled_named_colors = false,
      render = 'virtual',
      virtual_symbol_position = 'inline',
      enable_tailwind = true,
    },
  },
}
