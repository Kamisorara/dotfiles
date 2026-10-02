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
        -- 透明背景下浮窗必须实底（配合 config 里的高亮设置），winblend 会整体压透明度
        winblend = 0,
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

    -- 背景透明（transparent.lua）会把 Normal 清成无底色，Telescope 浮窗
    -- 因此融进终端背景看不清：给浮窗高亮组设实底色。
    -- 锚点用 NormalFloat/Pmenu——都不在透明清单里，保留配色的实色
    local solid = vim.api.nvim_get_hl(0, { name = 'NormalFloat' }).bg
      or vim.api.nvim_get_hl(0, { name = 'Pmenu' }).bg
      or '#2f3831'
    local fg = vim.api.nvim_get_hl(0, { name = 'Normal' }).fg
    for _, group in ipairs {
      'TelescopeNormal',
      'TelescopePromptNormal',
      'TelescopeResultsNormal',
      'TelescopePreviewNormal',
      'TelescopeBorder',
      'TelescopePromptBorder',
      'TelescopeResultsBorder',
      'TelescopePreviewBorder',
    } do
      local ok, hl =
        pcall(vim.api.nvim_get_hl, 0, { name = group, create = false })
      hl = ok and hl or {}
      -- link 组不能与 fg/bg 混设；default=true 会让设置退让于已有显式定义，
      -- 二者都必须显式清除
      hl.link = nil
      hl.default = nil
      hl.bg = solid
      hl.fg = hl.fg or fg
      pcall(vim.api.nvim_set_hl, 0, group, hl)
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
