-- indent-blankline: 缩进参考线（VS Code 同款竖向对齐线）
-- scope 额外高亮光标所在的当前层级（VS Code 没有的增强，不想要可关）
return {
  'lukas-reineke/indent-blankline.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'ibl',
  opts = {
    indent = {
      char = '▏',
    },
    scope = {
      enabled = true,
    },
  },
}
