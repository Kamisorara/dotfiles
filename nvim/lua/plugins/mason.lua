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
      'lua_ls',
      'pyright',
      'html',
      -- 'tsserver', -- 使用了 pmizio/typescript-tools.nvim 作为 TypeScript 的 LSP 插件
    }

    require('mason-lspconfig').setup {
      ensure_installed = lsp_servers, -- 确保 LSP 服务器已安装
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        'stylua',
        'eslint_d',
        'prettierd',
        'graphql-language-service-cli',
        'prisma-language-server',
        'autopep8',
        'fixjson',
        'prettier',
        'shfmt',
        'isort',
        'black',
        'html-lsp',
      }, -- 保留非 LSP 工具的安装
    }
  end,
}
