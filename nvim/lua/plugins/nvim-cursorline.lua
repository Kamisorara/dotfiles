return {
  'yamatsum/nvim-cursorline',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    cursorline = {
      enable = false,
      timeout = 1000,
      number = false,
    },
    cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
    },
  },
}
