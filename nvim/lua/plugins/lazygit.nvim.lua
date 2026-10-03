-- lazygit.nvim: 浮动窗口运行 lazygit，替代 neogit 作为主要 git 操作台
-- 配套命令：:LazyGitCurrentFile（按当前文件的项目根打开）、
-- :LazyGitFilter（提交日志过滤）、:LazyGitConfig（编辑 lazygit 配置）
-- 注意：在 lazygit 里按 e/o 想把文件打开到宿主 nvim 需要额外一步——
-- 装 nvr（pip install neovim-remote）或在 lazygit config.yml 配
-- editCommandTemplate 指向 nvim --server
return {
  'kdheepak/lazygit.nvim',
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    {
      '<leader>gg',
      '<cmd>LazyGit<cr>',
      desc = 'lazygit',
      silent = true,
    },
  },
}
