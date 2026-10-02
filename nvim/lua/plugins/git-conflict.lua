-- git-conflict.nvim: 合并冲突高亮 + 一键取舍
-- 冲突 buffer 内默认键位：co=ours ct=theirs cb=both c0=none，]x/[x 跳冲突
return {
  'akinsho/git-conflict.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('git-conflict').setup {
      -- 冲突未解决期间关掉该 buffer 的诊断，避免和冲突标记叠加噪音
      disable_diagnostics = true,
    }
  end,
}
