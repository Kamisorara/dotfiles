return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require 'lspconfig'

    -- for fold
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Enhance capabilities with nvim-cmp (completion plugin)
    local cmp_capabilities =
      require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- graphql
    lspconfig.graphql.setup {
      filetypes = {
        'graphql',
        'gql',
      },
      capabilities = cmp_capabilities,
    }

    -- lua
    lspconfig.lua_ls.setup {
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
      capabilities = cmp_capabilities,
    }

    -- prisma
    lspconfig.prismals.setup {
      capabilities = cmp_capabilities,
    }

    -- css
    lspconfig.cssls.setup {
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
      filetypes = {
        'css',
        'scss',
        'less',
      },
      capabilities = cmp_capabilities,
    }
    --
    -- -- emmet_ls
    -- lspconfig.emmet_ls.setup {
    --   filetypes = {
    --     'html',
    --     'css',
    --     'scss',
    --     'javascript',
    --     'typescriptreact',
    --     'javascriptreact',
    --     'haml',
    --     'xml',
    --     'xsl',
    --     'pug',
    --     'slim',
    --     'sass',
    --     'stylus',
    --     'less',
    --     'sss',
    --     'hbs',
    --     'handlebars',
    --   },
    --   capabilities = cmp_capabilities,
    -- }
  end,
}
