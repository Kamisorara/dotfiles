return {
  {
    'nvim-treesitter/nvim-treesitter',
    -- version = 'v0.9.3',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'axelvc/template-string.nvim',
    },
    config = function()
      require('nvim-treesitter.config').setup {
        ensure_installed = {
          'tsx',
          'lua',
          'vim',
          'typescript',
          'javascript',
          'html',
          'css',
          'json',
          'graphql',
          'regex',
          'prisma',
          'markdown',
          'markdown_inline',
          'diff',
          'vue',
        },

        sync_install = true,

        auto_install = true,

        highlight = {
          enable = true,

          additional_vim_regex_highlighting = false,
        },
        autotag = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<enter>',
            node_incremental = '<enter>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
      }

      require('template-string').setup {}
    end,
  },
}
