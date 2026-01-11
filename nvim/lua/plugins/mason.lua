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

    -- 添加 LSP 服务器列表 (vue_ls 需要手动配置)
    local lsp_servers = {
      'clangd',
      'cssls',
      'emmet_ls',
      'html',
      'jsonls',
      'jdtls', -- Java
      'lua_ls',
      'pyright',
    }

    require('mason-lspconfig').setup {
      ensure_installed = lsp_servers,
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        'autopep8',
        'eslint_d',
        'fixjson',
        'google-java-format', -- Java formatter
        'graphql-language-service-cli',
        'html-lsp',
        'prettier',
        'prettierd',
        'prisma-language-server',
        'shfmt',
        'stylua',
        -- 'black', -- 已通过 pip 安装
        -- 'isort', -- 已通过 pip 安装
      },
    }
  end,
}
