local g = vim.g -- 使用简写来访问全局 Vim 变量
local opt = vim.opt -- 使用简写来访问 Vim 选项

g.encoding = 'UTF-8' -- 设置全局编码为 UTF-8

-- 禁用未使用的内置 provider（本配置无任何插件依赖 node/python/perl/ruby）
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_python3_provider = 0
g.loaded_ruby_provider = 0
opt.fileencoding = 'utf-8' -- 设置文件编码为 UTF-8

-- local win_height = vim.fn.winheight(0) -- 获取当前窗口的高度（此行被注释掉了）
-- opt.scrolloff = math.floor((win_height - 1) / 2) -- 设置滚动时距离顶部的行数（此行被注释掉了）
-- opt.sidescrolloff = math.floor((win_height - 1) / 2) -- 设置横向滚动时距离左侧的列数（此行被注释掉了）
opt.scrolloff = 7 -- 在靠近顶部或底部时保持至少 7 行可见
opt.sidescrolloff = 8 -- 在靠近左侧或右侧时保持至少 8 列可见

opt.clipboard = 'unnamedplus' -- 与系统剪贴板同步
opt.smartindent = true -- 启用智能缩进
opt.number = true -- 显示行号
opt.relativenumber = false -- 显示相对行号

opt.cursorline = true -- 高亮显示当前行

opt.signcolumn = 'yes' -- 始终显示标志列

-- opt.colorcolumn = "80"        -- 在第 80 列显示垂直参考线

opt.tabstop = 2 -- Tab 键显示为 2 个空格
opt.softtabstop = 2 -- 插入模式下 Tab 键的宽度为 2 个空格
opt.shiftround = true -- 使用 >> 或 << 命令时对齐缩进到 shiftwidth 的倍数
opt.expandtab = true -- 将 Tab 键转换为空格

opt.shiftwidth = 2 -- 自动缩进使用 2 个空格

opt.autoindent = true -- 启用自动缩进

opt.ignorecase = true -- 搜索时忽略大小写
opt.smartcase = true -- 当搜索包含大写字母时区分大小写

opt.incsearch = true -- 输入搜索内容时实时显示匹配结果
opt.autoread = true -- 当文件被外部修改时自动加载文件

opt.wrap = false -- 禁用自动换行

opt.whichwrap = '<,>,[,]' -- 允许使用左右箭头键在行首和行尾之间移动

opt.hidden = true -- 允许隐藏已修改但未保存的缓冲区

opt.mouse = 'a' -- 在所有模式下启用鼠标支持

opt.backup = false -- 禁用备份文件
opt.writebackup = false -- 禁用写入备份文件
opt.swapfile = false -- 禁用交换文件

opt.undofile = true -- 持久化撤销历史，重启后仍可撤销（undotree 跨会话可用）

opt.updatetime = 200 -- 设置较短的更新间隔时间（单位为毫秒）

opt.timeoutlen = 300 -- 等待映射序列完成的时间（单位为毫秒），which-key 弹出更跟手

opt.splitbelow = true -- 水平分割窗口时在下方打开新窗口
opt.splitright = true -- 垂直分割窗口时在右侧打开新窗口

opt.smoothscroll = true -- Neovim 原生平滑滚动（替代 neoscroll.nvim）

-- Treesitter 折叠（0.10+ 原生；没有解析器的文件类型自动回退，不折叠）
opt.foldmethod = 'expr'
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevelstart = 99 -- 打开文件时默认全部展开

opt.completeopt = 'menu,menuone,noinsert,noselect' -- 启用自动完成菜单，并禁止自动选择第一个选项
opt.wildmenu = true -- 启用命令行的补全菜单

opt.termguicolors = true -- 启用终端的 24 位真彩色支持

opt.shortmess = vim.o.shortmess .. 'c' -- 避免出现 "按下 Enter 键继续" 的提示，不将消息传递到插入模式完成菜单

opt.pumheight = 16 -- 设置自动完成弹出菜单的最大行数为 16 行

opt.showtabline = 2 -- 始终显示标签行

opt.showmode = false -- 隐藏模式提示
-- opt.laststatus = 3          -- （此行被注释掉了）

opt.nrformats = 'bin,hex,alpha' -- 设置数字格式，支持二进制、十六进制和字母表示法

-- 在终端模式中禁用行号和相对行号
-- （原写法把 Lua 风格的 `-- 注释` 放进了 vim.cmd 块，VimL 里会被当成
-- 选项名解析，TermOpen 抛 E518 并中断 jobstart——lazygit 首次触发此路径）
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('UserTermOpen', { clear = true }),
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
  end,
})

-- 文件类型检测
vim.filetype.add {
  extension = {
    vue = 'vue',
  },
}

-- 复制时短暂高亮复制区域
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('UserYankHighlight', {}),
  callback = function()
    vim.hl.on_yank()
  end,
})
