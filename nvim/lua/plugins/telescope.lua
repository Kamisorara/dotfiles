return {
  'nvim-telescope/telescope.nvim',
  -- version = '0.1.8',
  -- dashboard 的 center 动作通过 :Telescope 命令触发，需要 cmd 懒加载入口
  cmd = 'Telescope',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- 没有 make（常见于 Windows）时优雅跳过，退回内置排序器
      build = function()
        if vim.fn.executable 'make' ~= 1 then
          vim.notify(
            'telescope-fzf-native: 未找到 make，跳过本地构建，使用默认排序器',
            vim.log.levels.WARN
          )
          return
        end
        local ok = pcall(vim.fn.system, { 'make' })
        if not ok or vim.v.shell_error ~= 0 then
          vim.notify(
            'telescope-fzf-native 构建失败，使用默认排序器',
            vim.log.levels.WARN
          )
        end
      end,
    },
  },
  opts = {
    defaults = {
      -- winblend 必须 0：>0 会把 nvim 内部（后面的代码）透出来。
      -- 浮窗不设底色时（见 config），picker 区域被无底色空白格覆盖：
      -- 后面的代码被盖掉，透出的是终端自身背景（WT acrylic 磨砂）
      winblend = 0,
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

    -- 毛玻璃方案：浮窗完全不留自己的底色（transparent.lua 已把 Normal
    -- 清空，Telescope* 组链到它），picker 区域由无底色空白格覆盖——
    -- 后面的代码被盖住，透出终端自身背景（Windows Terminal 的 acrylic
    -- 磨砂即在此生效）。只显式保留边框前景色，保证浮窗轮廓可见
    local fg = vim.api.nvim_get_hl(0, { name = 'WinBorder', create = false }).fg
      or vim.api.nvim_get_hl(0, { name = 'Comment' }).fg
      or '#859289'
    for _, group in ipairs {
      'TelescopeBorder',
      'TelescopePromptBorder',
      'TelescopeResultsBorder',
      'TelescopePreviewBorder',
    } do
      vim.api.nvim_set_hl(0, group, { fg = fg })
    end
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
      '<leader>/',
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

        pickers
          .new({}, {
            prompt_title = 'Environment Variables',
            sorter = conf.generic_sorter {},
            finder = finders.new_table { results = entries },
          })
          :find()
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
