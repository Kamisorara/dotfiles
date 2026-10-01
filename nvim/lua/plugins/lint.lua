-- ESLint 诊断（nvim-lint + eslint_d）
-- eslint_d 是常驻进程，速度接近即时；项目里没有 eslint 配置时自动跳过
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      vue = { 'eslint_d' },
    }

    -- 覆盖 flat config 和传统 .eslintrc 两种格式
    local eslint_config_files = {
      'eslint.config.js',
      'eslint.config.mjs',
      'eslint.config.cjs',
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.json',
      '.eslintrc.yaml',
      '.eslintrc.yml',
    }

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('UserLint', { clear = true }),
      callback = function(args)
        -- 只在项目根能找到 eslint 配置时才跑，避免无关项目里报错
        if vim.fs.root(args.buf, eslint_config_files) then
          require('lint').try_lint()
        end
      end,
    })
  end,
}
