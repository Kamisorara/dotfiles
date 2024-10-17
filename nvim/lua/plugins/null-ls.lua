return {
  'nvimtools/none-ls.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  event = 'VeryLazy',
  config = function()
    local null_ls = require 'null-ls'

    local formatting = null_ls.builtins.formatting

    null_ls.setup {
      debug = false,
      sources = {
        formatting.shfmt,
        formatting.stylua,
        formatting.csharpier,
        formatting.prettier.with {
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
            'css',
            'scss',
            'less',
            'html',
            'json',
            'yaml',
            'graphql',
          },
          extra_filetypes = { 'njk' },
          prefer_local = 'node_modules/.bin',
        },
        -- formatting.autopep8,
      },
      diagnostics_format = '[#{s}] #{m}',
    }
  end,
}
