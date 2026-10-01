return {
  'nvim-telescope/telescope.nvim',
  -- version = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        'rg',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--hidden',
        '--glob=!.git/',
      },
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
      file_ignore_patterns = {
        'node_modules',
        'android',
        'ios',
        '.git',
        '.idea',
        '.vs',
      },
    },
    pickers = {
      find_files = {
        winblend = 20,
        previewer = false, -- 禁用预览提高速度
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
  end,
  keys = {
    {
      '<leader>f',
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
      function()
        -- 浏览环境变量（替代已失效的 LinArcX/telescope-env.nvim）
        local pickers = require 'telescope.pickers'
        local finders = require 'telescope.finders'
        local conf = require('telescope.config').values

        local entries = {}
        for k, v in pairs(vim.fn.environ()) do
          entries[#entries + 1] = string.format('%s=%s', k, v)
        end
        table.sort(entries)

        pickers.new({}, {
          prompt_title = 'Environment Variables',
          sorter = conf.generic_sorter {},
          finder = finders.new_table { results = entries },
        }):find()
      end,
      desc = 'environment variables',
    },
    -- git 查找
    {
      '<leader>gc',
      ':Telescope git_commits<CR>',
      desc = 'git commits',
      silent = true,
      noremap = true,
    },
    {
      '<leader>gC',
      ':Telescope git_bcommits<CR>',
      desc = 'git commits (current file)',
      silent = true,
      noremap = true,
    },
    {
      '<leader>gS',
      ':Telescope git_status<CR>',
      desc = 'git status',
      silent = true,
      noremap = true,
    },
  },
}
