return {
  { 'NvChad/nvim-colorizer.lua', enabled = false },
  {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    cmd = 'HighlightColors',
    opts = {
      enabled_named_colors = false,
      render = 'virtual',
      virtual_symbol_position = 'inline',
      enable_tailwind = true,
    },
  },
}
