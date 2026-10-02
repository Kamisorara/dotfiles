return {
  -- 仓库已从 williamboman/* 迁移到 mason-org/*（旧地址靠 GitHub 重定向）
  'mason-org/mason.nvim',
  -- 推迟到首个文件打开前加载：早于 FileType / LSP 启动，
  -- mason 的 PATH 注入仍然先于 server 查找；dashboard 空启动不再付 mason 成本
  event = { 'BufReadPre', 'BufNewFile' },
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
    -- 注意 jdtls 只负责安装，启动由 lua/plugins/lsp-java.lua（nvim-jdtls）接管
    local lsp_servers = {
      'clangd',
      'cssls',
      'emmet_ls',
      'html',
      'jdtls',
      'jsonls',
      'lua_ls',
      'prismals',
      'pyright',
      'ruff', -- Python lint（类型检查由 pyright 负责）
      'vtsls', -- TypeScript with Vue support
      'vue_ls', -- Vue language server
    }

    require('mason-lspconfig').setup {
      ensure_installed = lsp_servers,
      -- 关闭自动启用：服务器统一在 lspconfig.lua 里显式 vim.lsp.enable；
      -- 也避免 lspconfig 的 jdtls 与 nvim-jdtls 双启动
      automatic_enable = false,
    }

    -- 格式化/Lint 工具，与 conform.nvim 的 formatters_by_ft 对应
    require('mason-tool-installer').setup {
      ensure_installed = {
        'eslint_d',
        'google-java-format',
        'graphql-language-service-cli',
        'prettierd', -- 只保留 prettierd，不再重复安装 prettier
        'ruff', -- python 格式化 + import 排序（Rust 单二进制，无 Python 依赖）
        'shfmt',
        'stylua',
      },
    }
  end,
}
