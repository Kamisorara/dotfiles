return {
  {
    'nvim-tree/nvim-tree.lua',
    version = 'v1.11.0',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      local api = require 'nvim-tree.api'
      vim.keymap.set('n', '<leader>e', api.tree.toggle)

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

        -- default mappings
        api.config.mappings.default_on_attach(bufnr)

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
          update_cwd = true,
        },
        git = {
          enable = false,
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
