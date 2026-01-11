return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Enhance capabilities with nvim-cmp (completion plugin)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Configure LSP servers using Neovim 0.11+ API
    vim.lsp.config('graphql', {
      filetypes = { 'graphql', 'gql' },
      capabilities = capabilities,
    })

    -- lua
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      capabilities = capabilities,
    })

    -- prisma
    vim.lsp.config('prismals', {
      capabilities = capabilities,
    })

    -- css
    vim.lsp.config('cssls', {
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = 'ignore',
          },
        },
        less = {
          validate = true,
          lint = {
            unknownAtRules = 'ignore',
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = 'ignore',
          },
        },
      },
      filetypes = { 'css', 'scss', 'less' },
      capabilities = capabilities,
    })

    -- python
    vim.lsp.config('pyright', {
      capabilities = capabilities,
    })

    -- html
    vim.lsp.config('html', {
      capabilities = capabilities,
    })

    -- vue (Volar) - 使用完整路径因为 vue-language-server 不在 PATH 中
    vim.lsp.config('vue_ls', {
      cmd = {
        'node',
        vim.fn.stdpath 'data' .. '/mason/packages/vue-language-server/node_modules/@vue/language-server/bin/vue-language-server.js',
        '--stdio',
      },
      filetypes = { 'vue' },
      capabilities = capabilities,
      root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', '.git'),
    })

    -- Enable all configured LSP servers
    -- 注意: ts_ls 由 typescript-tools.nvim 管理
    vim.lsp.enable('graphql', 'lua_ls', 'prismals', 'cssls', 'pyright', 'html', 'vue_ls')
  end,
}
