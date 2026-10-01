return {
  -- 仓库已从 williamboman/* 迁移到 mason-org/*（旧地址靠 GitHub 重定向）
  'mason-org/mason.nvim',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
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

    -- LSP 服务器（mason-lspconfig 会安装并注册对应的 mason 包）
    local lsp_servers = {
      'clangd',
      'cssls',
      'emmet_ls',
      'html',
      'jsonls',
      'lua_ls',
      'prismals',
      'pyright',
      'vtsls', -- TypeScript with Vue support
      'vue_ls', -- Vue language server
    }

    require('mason-lspconfig').setup {
      ensure_installed = lsp_servers,
    }

    -- 格式化/Lint 工具，与 conform.nvim 的 formatters_by_ft 对应
    require('mason-tool-installer').setup {
      ensure_installed = {
        'eslint_d',
        'graphql-language-service-cli',
        'prettierd', -- 只保留 prettierd，不再重复安装 prettier
        'shfmt',
        'stylua',
        -- python 的 black/isort 已通过 pip 安装
      },
    }
  end,
}
