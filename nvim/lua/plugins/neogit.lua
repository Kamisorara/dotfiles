return {
  'NeogitOrg/neogit',
  -- version = 'v0.0.1',
  dependencies = 'nvim-lua/plenary.nvim',
  main = 'neogit',
  opts = {
    status = {
      recent_commit_count = 30,
    },
  },
  keys = {
    {
      '<leader>gt',
      ':Neogit<CR>',
      desc = 'neogit',
      silent = true,
      noremap = true,
    },
  },
}
