return {
  'stevearc/conform.nvim',
  event = 'VeryLazy',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        json = { 'prettierd' },
        lua = { 'stylua' },
        graphql = { 'prettierd' },
        markdown = { 'prettierd' },
        python = { 'isort', 'black' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        vue = { 'prettierd' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        yaml = { 'prettierd' },
      },
      -- 保存自动格式化
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        -- 没有配置专用 formatter 的文件类型回退到 LSP 格式化
        -- （lsp_fallback 选项已弃用，改用 lsp_format）
        lsp_format = 'fallback',
      },
    }
  end,
}
