return {
  'smoka7/hop.nvim',
  version = 'v2.7.2',
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
