# Neovim 配置

现代化的 Lua Neovim 配置，使用 lazy.nvim 作为插件管理器。

## 特性

- **插件管理器**: lazy.nvim
- **LSP 支持**: TypeScript/JavaScript (vtsls), Vue (vue_ls), Java (nvim-jdtls), Python, GraphQL, Lua, Prisma, CSS, HTML
- **自动补全**: nvim-cmp（支持 LSP、代码片段、缓冲区和路径）
- **Git 集成**: Gitsigns, Neogit, Diffview, Telescope git pickers

### 环境依赖

- Neovim >= 0.11、git、Node.js 18+（vtsls / pyright / prettierd 等 npm 系工具需要）
- JDK 17+（仅 Java 项目）
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter-cli)（`main` 分支的 nvim-treesitter 用它编译解析器）：`npm install -g tree-sitter-cli` 或 `cargo install tree-sitter-cli` 或 `brew install tree-sitter`
- C 编译器（编译解析器用）；Windows 上还需设置 `CC=gcc`（tree-sitter CLI 默认找 MSVC 的 cl.exe）
- `rg`（ripgrep，Telescope live_grep 用）

LSP 服务器与格式化工具全部由 Mason 自动安装。Python 开发**无需预装系统 Python**：解释器自动使用项目根的 `.venv`（标准 venv / uv / poetry 均可，不激活也能正确分析），格式化用 ruff（独立二进制，零 Python 依赖）。
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
| `<leader>gn` / `]h` | 跳转到下一个 hunk |
| `<leader>gp` / `[h` | 跳转到上一个 hunk |
| `<leader>gP` | 预览 hunk |
| `<leader>gs` | 暂存 hunk（可视模式暂存选中行；对已暂存的 hunk 再按一次取消暂存） |
| `<leader>gr` | 重置 hunk（可视模式重置选中行） |
| `<leader>gu` | 取消暂存整个缓冲区 |
| `<leader>gb` | 暂存整个缓冲区 |
| `<leader>gl` | 开关当前行的 git blame |
| `<leader>gd` | 当前文件与暂存区对比 |
| `<leader>gD` | 当前文件与 HEAD 对比 |
| `ih` | hunk 文本对象（`dih`/`yih`/`cih`） |
| `<leader>gt` | 打开 Neogit |
| `<leader>go` / `<leader>gq` | Diffview 打开/关闭（审阅全部改动） |
| `<leader>gh` / `<leader>gH` | 当前文件/整个仓库的提交历史 (Diffview) |
| `<leader>gc` | 搜索所有提交 (Telescope) |
| `<leader>gC` | 搜索当前文件的提交 (Telescope) |
| `<leader>gS` | 查看 git status (Telescope) |

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

### TypeScript / Java 工具

| 按键 | 功能 |
|-----|------|
| `<leader>m` | 整理 imports（TS: vtsls / Java: nvim-jdtls） |
| `<leader>a` | 添加缺失的 imports（vtsls） |

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

### 自动补全（插入模式）

| 按键 | 功能 |
|-----|------|
| `<C-Space>` | 触发补全 |
| `<CR>` | 确认选择 |

### 平滑滚动

已启用 Neovim 原生 `smoothscroll`（不再使用 neoscroll.nvim），`<C-u>`/`<C-d>`/`zt`/`zz`/`zb` 等按键为原生行为。

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
│   ├── symbols.lua       # 图标字典
│   ├── transparent.lua   # 原生背景透明（:TransparentToggle）
│   └── plugins/          # 插件配置（一个插件一个文件）
│       ├── auto-save.lua
│       ├── bufferline.lua
│       ├── colorizer.lua
│       ├── colorscheme.lua
│       ├── comment.lua
│       ├── conform.lua   # 保存时格式化（唯一的格式化入口）
│       ├── dashboard.lua
│       ├── diffview.lua  # git diff / 历史
│       ├── gitsigns.lua
│       ├── hop.lua
│       ├── lsp-java.lua    # Java LSP (nvim-jdtls)
│       ├── lspconfig.lua # vtsls + vue_ls 等 LSP
│       ├── lspsaga.lua
│       ├── lualine.lua
│       ├── mason.lua
│       ├── neogit.lua
│       ├── noice.lua
│       ├── nvim-autopair.lua
│       ├── nvim-cmp.lua
│       ├── nvim-cursorline.lua
│       ├── nvim-tree.lua
│       ├── nvim-treesitter.lua
│       ├── surround.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── undotree.lua
│       └── which-key.lua
├── snippets/             # VS Code 格式代码片段
└── lazy-lock.json       # 插件版本锁定文件
```
