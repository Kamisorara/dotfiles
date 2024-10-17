return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  event = 'VeryLazy',
  config = function()
    local api = require 'typescript-tools.api'

    -- 移除未使用的imports
    vim.keymap.set('n', '<leader>m', '<cmd>TSToolsOrganizeImports<cr>')
    -- 添加缺少的imports
    vim.keymap.set('n', '<leader>a', '<cmd>TSToolsAddMissingImports<cr>')
    require('typescript-tools').setup {
      handlers = {
        ['textDocument/publishDiagnostics'] = api.filter_diagnostics { 80006 },
      },
      settings = {
        tsserver_file_preferences = {
          -- 自动导入包的时候使用绝对路径
          importModuleSpecifierPreference = 'non-relative',
        },
        -- 标签闭合
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
      },
    }
  end,
}
