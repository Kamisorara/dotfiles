return {
  {
    'nvim-tree/nvim-tree.lua',
    version = 'v1.18.0',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    -- 按键懒加载：打开文件树时才加载整个插件（省约 50ms 启动时间）
    keys = {
      {
        '<leader>e',
        function()
          require('nvim-tree.api').tree.toggle()
        end,
        desc = 'nvim-tree: toggle',
      },
    },
    init = function()
      -- 必须在插件加载前禁用 netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    config = function()
      local api = require 'nvim-tree.api'

      local function my_on_attach(bufnr)
        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- default mappings（v1.18 起 api.config.mappings.default_on_attach
        -- 改名为 api.map.on_attach.default）
        api.map.on_attach.default(bufnr)

        -- custom mappings
        vim.keymap.set('n', '<leader>e', api.tree.toggle, opts 'Toggle')
        vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
      end

      require('nvim-tree').setup {
        view = {
          width = 30,
          side = 'left',
          number = false,
          relativenumber = false,
          signcolumn = 'yes',
        },
        on_attach = my_on_attach,
        update_focused_file = {
          enable = true,
          -- v1.18 起 update_cwd 布尔值改为 update_root 表
          update_root = {
            enable = true,
          },
        },
        git = {
          enable = true, -- 文件树里显示 git 修改标记
        },
        filters = {
          dotfiles = false,
          custom = {
            'node_modules',
            '.git/',
            '.DS_Store',
            '__pycache__',
            '*.pyc',
            'venv',
            '.venv',
            'env',
            '.env',
            '.pytest_cache',
            '.mypy_cache',
            'dist',
            'build',
          },
          exclude = { '.gitignore' },
        },
        diagnostics = {
          enable = true,
          show_on_dirs = true,
          icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
          },
        },
        actions = {
          open_file = {
            resize_window = true,
            quit_on_open = true,
          },
        },
      }
    end,
  },
}
