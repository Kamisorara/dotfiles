-- nvim-treesitter 的 main 分支是完全重写版：
--   - 解析器安装用 require('nvim-treesitter').install {}
--   - 高亮启用用 Neovim 内置的 vim.treesitter.start()
--   - ensure_installed / highlight / incremental_selection 等旧选项已删除
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTreesitter', {}),
        callback = function(args)
          -- 没有对应解析器的文件类型自动回退到正则高亮
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
    config = function()
      require('nvim-treesitter').install {
        'bash',
        'css',
        'diff',
        'graphql',
        'html',
        'java',
        'javascript',
        'json',
        'kotlin',
        'lua',
        'markdown',
        'markdown_inline',
        'prisma',
        'python',
        'query',
        'regex',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      }
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'axelvc/template-string.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
}
