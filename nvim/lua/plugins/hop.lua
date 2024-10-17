return {
  'phaazon/hop.nvim',
  version = 'v2.0.3',
  main = 'hop',
  opts = {
    -- This is actually equal to:
    --   require("hop.hint").HintPosition.END
    hint_position = 3,
    keys = 'fjghdksltyrueiwoqpvbcnxmza',
  },
  keys = {
    {
      '<leader>hp',
      ':HopWord<CR>',
      desc = 'hop word',
      silent = true,
      noremap = true,
    },
  },
}
