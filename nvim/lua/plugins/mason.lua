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

    -- 添加 LSP 服务器列表
    local lsp_servers = {
      'clangd',
      'cssls',
      'emmet_ls',
      'html',
      'jsonls',
      'jdtls', -- Java
      'lua_ls',
      'pyright',
      'vtsls', -- TypeScript with Vue support
      'vue_ls', -- Vue language server
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
        'vue-language-server', -- Vue LSP (Volar)
        -- 'black', -- 已通过 pip 安装
        -- 'isort', -- 已通过 pip 安装
      },
    }
  end,
}
