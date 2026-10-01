return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP 补全 capabilities
  },
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

    -- python: pyright，自动探测项目虚拟环境（.venv/venv）里的解释器，
    -- 不激活 venv 也能正确分析第三方库
    vim.lsp.config('pyright', {
      capabilities = capabilities,
      before_init = function(_, config)
        local root = vim.fs.root(0, {
          '.git',
          'pyproject.toml',
          'setup.py',
          'setup.cfg',
          'requirements.txt',
        })
        if not root then
          return
        end
        local suffixes = vim.fn.has 'win32' == 1
            and { '/Scripts/python.exe', '/Scripts/python' }
          or { '/bin/python', '/bin/python3' }
        for _, venv in ipairs { root .. '/.venv', root .. '/venv' } do
          for _, suffix in ipairs(suffixes) do
            local python = venv .. suffix
            if vim.fn.executable(python) == 1 then
              config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
                python = { pythonPath = python },
              })
              return
            end
          end
        end
      end,
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

    -- vue_ls (Vue language server)，root 目录由上游默认配置决定
    vim.lsp.config('vue_ls', {
      filetypes = { 'vue' },
      capabilities = capabilities,
    })

    -- Enable all configured LSP servers
    -- 注意: vtsls 替代了 typescript-tools.nvim 用于 TypeScript + Vue
    -- vim.lsp.enable 只接受单个名字或一个 table，不能传多个参数
    -- clangd/emmet_ls/jsonls 无需自定义配置，直接启用上游默认配置；
    -- jdtls 不在此列——由 lua/plugins/lsp-java.lua（nvim-jdtls）启动
    vim.lsp.enable {
      'graphql',
      'lua_ls',
      'prismals',
      'cssls',
      'pyright',
      'html',
      'vtsls',
      'vue_ls',
      'clangd',
      'emmet_ls',
      'jsonls',
    }
  end,
}
