# Neovim 配置

现代化的 Lua Neovim 配置，使用 lazy.nvim 作为插件管理器。

## 特性

- **插件管理器**: lazy.nvim
- **LSP 支持**: TypeScript/JavaScript, Vue, Java, Python, GraphQL, Lua, Prisma, CSS, HTML
- **自动补全**: nvim-cmp（支持 LSP、代码片段、缓冲区和路径）
- **Git 集成**: Gitsigns, Neogit
- **模糊查找**: Telescope
- **配色方案**: Everforest

---

## 快捷键

**Leader 键**: `<Space>`（空格键）

### 全局快捷键

| 按键 | 模式 | 功能 |
|-----|------|------|
| `<C-a>` | 普通 | 全选 (ggVG) |
| `<leader>p` | 普通/可视 | 从寄存器 0 粘贴 |
| `<leader>q` | 普通 | 退出 Neovim |
| `<leader>s` | 普通 | 保存文件 |
| `<leader>x` | 普通 | 保存并退出 |
| `j` | 普通 | 向下移动（支持换行） |
| `k` | 普通 | 向上移动（支持换行） |
| `<leader>nh` | 普通 | 清除搜索高亮 |

### 缓冲区管理 (`<leader>b`)

| 按键 | 功能 |
|-----|------|
| `<leader>bc` | 选择并关闭缓冲区 |
| `<leader>bd` | 关闭当前缓冲区 |
| `<leader>bh` | 切换到上一个缓冲区 |
| `<leader>bl` | 切换到下一个缓冲区 |
| `<leader>bo` | 关闭其他缓冲区 |
| `<leader>bp` | 选择缓冲区（切换） |

### 注释操作 (`<leader>c`)

| 按键 | 模式 | 功能 |
|-----|------|------|
| `<leader>c` | 普通 | 切换行注释 |
| `<leader>ca` | 普通 | 切换块注释 |
| `<leader>cc` | 普通/可视 | 切换行注释（当前行/选中行） |
| `<leader>cb` | 普通/可视 | 切换块注释（当前行/选中行） |
| `<leader>co` | 普通 | 在下方插入注释 |
| `<leader>cO` | 普通 | 在上方插入注释 |
| `<leader>cA` | 普通 | 在行尾插入注释 |

### Git 操作 (`<leader>g`)

| 按键 | 功能 |
|-----|------|
| `<leader>gn` | 跳转到下一个 hunk |
| `<leader>gp` | 跳转到上一个 hunk |
| `<leader>gP` | 预览 hunk |
| `<leader>gs` | 暂存 hunk |
| `<leader>gu` | 取消暂存 hunk |
| `<leader>gr` | 重置 hunk |
| `<leader>gb` | 暂存整个缓冲区 |
| `<leader>gt` | 打开 Neogit |

### LSP 操作 (`<leader>l`)

| 按键 | 模式 | 功能 |
|-----|------|------|
| `<leader>ld` | 普通 | 跳转到定义 |
| `<leader>lr` | 普通 | 重命名 |
| `<leader>lc` | 普通/可视 | 代码操作 |
| `gr` | 普通 | 查找引用 |
| `<leader>lk` / `<leader>lh` | 普通 | 悬停文档 |
| `<leader>lR` | 普通 | LSP 查找器（引用/定义/实现） |
| `<leader>li` | 普通 | 跳转到实现 |
| `<leader>lo` | 普通 | 符号大纲 |
| `<leader>lP` | 普通 | 显示当前行诊断 |
| `<leader>ln` | 普通 | 下一个诊断 |
| `<leader>lp` | 普通 | 上一个诊断 |
| `<leader>ly` | 普通 | 复制行诊断 |

### TypeScript 工具

| 按键 | 功能 |
|-----|------|
| `<leader>m` | 整理 imports |
| `<leader>a` | 添加缺失的 imports |

### Telescope 模糊查找 (`<leader>f`, `<leader>t`)

| 按键 | 功能 |
|-----|------|
| `<leader>f` | 查找文件 |
| `<leader>t<C-f>` | 全局搜索 |
| `<leader>te` | 浏览环境变量 |
| `:Telescope buffers` | 列出打开的缓冲区 |
| `:Telescope help_tags` | 搜索 Neovim 帮助 |
| `:Telescope oldfiles` | 最近打开的文件 |
| `:Telescope git_files` | Git 文件 |

**Telescope 内部快捷键（插入模式）：**

| 按键 | 功能 |
|-----|------|
| `<C-j>` | 选择下一项 |
| `<C-k>` | 选择上一项 |
| `<C-n>` | 下一个历史记录 |
| `<C-p>` | 上一个历史记录 |
| `<C-c>` | 关闭 |
| `<C-u>` | 预览向上滚动 |
| `<C-d>` | 预览向下滚动 |

### 文件浏览器

| 按键 | 功能 |
|-----|------|
| `<leader>e` | 切换文件树 |

### 导航

| 按键 | 功能 |
|-----|------|
| `<leader>hp` | Hop 快速跳转到单词 |
| `]t` | 下一个 TODO 注释 |
| `[t` | 上一个 TODO 注释 |
| `<leader>t` | 搜索 TODO 注释 (Telescope) |

### 工具 (`<leader>u`)

| 按键 | 功能 |
|-----|------|
| `<leader>uu` | 切换撤销树 |

### Treesitter 增量选择

| 按键 | 功能 |
|-----|------|
| `<enter>` | 开始/扩大选择范围 |
| `<bs>` | 缩小选择范围 |

### 自动补全（插入模式）

| 按键 | 功能 |
|-----|------|
| `<C-Space>` | 触发补全 |
| `<CR>` | 确认选择 |

### 平滑滚动

| 按键 | 功能 |
|-----|------|
| `<C-u>` | 向上滚动半屏 |
| `<C-d>` | 向下滚动半屏 |
| `<C-b>` | 向上滚动一屏 |
| `<C-f>` | 向下滚动一屏 |
| `<C-y>` | 向上滚动 |
| `<C-e>` | 向下滚动 |
| `zt` | 当前行置顶 |
| `zz` | 当前行居中 |
| `zb` | 当前行置底 |

### Which-Key 分组

| 前缀 | 描述 |
|--------|------|
| `<leader>b` | 缓冲区操作 |
| `<leader>c` | 注释操作 |
| `<leader>g` | Git 操作 |
| `<leader>h` | Hop 操作 |
| `<leader>l` | LSP 操作 |
| `<leader>t` | Telescope/Todo 操作 |
| `<leader>u` | 工具操作 |

### Vim Surround

使用插件内置快捷键：

| 按键 | 功能 |
|-----|------|
| `cs"'` | 将包围的 `"` 改为 `'` |
| `ysiw"` | 给单词添加 `"` 包围 |
| `ds"` | 删除包围的 `"` |

---

## 插件管理

```vim
:Lazy          " 打开 lazy.nvim 界面
:Lazy sync     " 同步并安装/更新插件
:Lazy update   " 更新所有插件
:Lazy restore  " 恢复到 lazy-lock.json 锁定的版本
```

## LSP 工具

```vim
:Mason          " 打开 Mason 管理界面
:LspInfo        " 显示当前激活的 LSP 客户端
:TSInstallInfo  " 显示 Treesitter 解析器
```

## 常用命令

| 命令 | 功能 |
|------|------|
| `:UndotreeToggle` | 切换撤销树（快捷键: `<leader>uu`） |
| `:NvimTreeToggle` | 切换文件浏览器（快捷键: `<leader>e`） |
| `:TodoTelescope` | 搜索 TODO 注释（快捷键: `<leader>t`） |
| `:Noice` | Noice 命令日志 |
| `:Neogit` | 打开 Git 界面（快捷键: `<leader>gt`） |

---

## 文件结构

```
nvim/
├── init.lua              # 入口文件，引导 lazy.nvim
├── lua/
│   ├── base.lua          # Neovim 基础选项
│   ├── keymap.lua        # 全局快捷键
│   └── plugins/          # 插件配置
│       ├── auto-save.lua
│       ├── base.lua
│       ├── bufferline.lua
│       ├── clipboard.lua
│       ├── colorizer.lua
│       ├── Comment.nvim
│       ├── conform.lua
│       ├── dashboard-nvim.lua
│       ├── everforest.lua
│       ├── gitsigns.lua
│       ├── hop.lua
│       ├── lsp-java.lua
│       ├── lsp-typescript-tools.lua
│       ├── lspconfig.lua
│       ├── lspsaga.lua
│       ├── mason.lua
│       ├── neogit.lua
│       ├── neoscroll.lua
│       ├── noice.nvim
│       ├── nvim-autopairs.lua
│       ├── nvim-cmp.lua
│       ├── nvim-cursorline.lua
│       ├── nvim-notify.lua
│       ├── nvim-treesitter.lua
│       ├── nvim-tree.lua
│       ├── nvim-transparent.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── undotree.lua
│       ├── vim-surround.lua
│       └── which-key.lua
└── lazy-lock.json       # 插件版本锁定文件
```
