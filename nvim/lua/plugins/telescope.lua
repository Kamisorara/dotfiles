return {
  'nvim-telescope/telescope.nvim',
  version = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'LinArcX/telescope-env.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  opts = {
    defaults = {
      initial_mode = 'insert',
      mappings = {
        i = {
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<C-n>'] = 'cycle_history_next',
          ['<C-p>'] = 'cycle_history_prev',
          ['<C-c>'] = 'close',
          ['<C-u>'] = 'preview_scrolling_up',
          ['<C-d>'] = 'preview_scrolling_down',
        },
      },
      -- 排除node_modules里的文件
      file_ignore_patterns = { 'node_modules', 'android', 'ios' },
    },
    pickers = {
      find_files = {
        winblend = 20,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'env')
  end,
  keys = {
    {
      '<C-e>',
      ':Telescope find_files<CR>',
      desc = 'find file',
      silent = true,
      noremap = true,
    },
    {
      '<leader>t<C-f>',
      ':Telescope live_grep<CR>',
      desc = 'live grep',
      silent = true,
      noremap = true,
    },
    {
      '<leader>te',
      ':Telescope env<CR>',
      desc = 'n',
      silent = true,
      noremap = true,
    },
  },
}
