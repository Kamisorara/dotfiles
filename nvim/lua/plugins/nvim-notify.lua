return {
  'rcarriga/nvim-notify',
  version = 'v3.14.0',
  event = 'VeryLazy',
  opts = {
    timeout = 3000,
    background_colour = '#000000',
    stages = 'static',
  },
  config = function(_, opts)
    require('notify').setup(opts)
    vim.notify = require 'notify'
  end,
}
