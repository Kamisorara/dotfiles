-- rainbow-delimiters: 彩虹括号，不同嵌套层级的括号显示不同颜色
-- 高亮组 RainbowDelimiter{Red,Yellow,Blue,Orange,Green,Violet,Cyan}，
-- 配色主题定义了就用主题色（everforest 已内置），否则用插件默认色
return {
  'HiPhish/rainbow-delimiters.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
}
