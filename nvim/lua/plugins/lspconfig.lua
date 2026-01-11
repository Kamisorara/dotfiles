return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Enhance capabilities with nvim-cmp (completion plugin)
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Configure LSP servers using Neovim 0.11+ API

    -- graphql
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

    -- vtsls (TypeScript with Vue plugin)
    -- 配合 vue_ls 使用，为 Vue 文件提供完整的 TypeScript 支持
    local vue_language_server_path = vim.fn.stdpath 'data'
      .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'

    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vue_language_server_path,
      languages = { 'vue' },
      configNamespace = 'typescript',
    }

    vim.lsp.config('vtsls', {
      settings = {
        vtsls = {
          tsserver = {
            globalPlugins = {
              vue_plugin,
            },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
      capabilities = capabilities,
    })

    -- vue_ls (Vue language server)
    vim.lsp.config('vue_ls', {
      filetypes = { 'vue' },
      capabilities = capabilities,
      root_dir = require('lspconfig.util').root_pattern('package.json', 'tsconfig.json', '.git'),
    })

    -- Enable all configured LSP servers
    -- 注意: vtsls 替代了 typescript-tools.nvim 用于 TypeScript + Vue
    vim.lsp.enable('graphql', 'lua_ls', 'prismals', 'cssls', 'pyright', 'html', 'vtsls', 'vue_ls')
  end,
}
