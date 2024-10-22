return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  config = function()
    require('mason').setup {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    }

    require('mason-lspconfig').setup {}
    require('mason-tool-installer').setup {
      ensure_installed = {
        'typescript-language-server',
        'lua-language-server',
        'stylua',
        'eslint_d',
        'prettierd',
        'rust-analyzer',
        'graphql-language-service-cli',
        'prisma-language-server',
        'clangd',
        'eslint_d',
        'prettierd',
        'css-lsp',
        'emmet-ls',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'omnisharp',
        'pyright',
        'typescript-language-server',
        'autopep8',
        'csharpier',
        'fixjson',
        'prettier',
        'shfmt',
        'stylua',
        'isort',
        'black',
      },
    }
  end,
}
