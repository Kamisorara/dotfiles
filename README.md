# dotfiles

个人配置仓库：zsh（Zim）、Neovim（lazy.nvim）、tmux。

- Neovim 需要 >= 0.11（LSP 使用 `vim.lsp.config` / `vim.lsp.enable` 新 API）
- 部署方式是软链接（Windows 用 Junction）：仓库目录即生效目录，改完即用，没有同步步骤

## 新机器部署

先把仓库 clone 到任意固定路径。下文以 `~/dotfiles`（Unix）和 `D:\Data\Code\dotfiles`（Windows）为例，路径不同请自行替换。

### macOS / Linux

```bash
mkdir -p ~/.config
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/tmux ~/.config/tmux
ln -sfn ~/dotfiles/.zimrc ~/.zimrc      # zsh（Zim）配置
```

说明：

- `ln -sfn` 可重复执行，旧链接会被覆盖；若 `~/.config/nvim` 是真实目录（旧配置），先备份再删除
- tmux >= 3.2 才会读取 `~/.config/tmux`；旧版本把 `tmux/tmux.conf` 链到 `~/.tmux.conf` 即可

### Windows

Neovim 的配置目录是 `%LOCALAPPDATA%\nvim`。推荐用**目录联接（Junction）**：不需要管理员权限（`mklink /D` 符号链接需要管理员或开发者模式），且支持跨盘符（本机即 C: 链接到 D:）。

CMD（任意终端里都能执行）：

```cmd
mklink /J "%LOCALAPPDATA%\nvim" "D:\Data\Code\dotfiles\nvim"
```

PowerShell：

```powershell
New-Item -ItemType Junction -Path "$env:LOCALAPPDATA\nvim" -Target "D:\Data\Code\dotfiles\nvim"
```

Git Bash（`mklink` 是 cmd 内建命令，必须经 cmd 调用，注意双斜杠）：

```bash
cmd //c mklink //J "%LOCALAPPDATA%\nvim" "D:\Data\Code\dotfiles\nvim"
```

说明：

- 链接前若 `%LOCALAPPDATA%\nvim` 已存在（旧配置），先重命名或删除
- `%LOCALAPPDATA%\nvim-data`（插件、mason 工具、LSP 日志）由 Neovim 自动创建，**不要**链接进仓库
- 验证：`dir %LOCALAPPDATA% | findstr nvim` 应看到一行 `<JUNCTION>`
- tmux / zsh 不适用于 Windows，跳过

### 首次启动

1. 第一次打开 Neovim 会自动 bootstrap lazy.nvim，并按 `lazy-lock.json` 安装全部插件
2. 打开任意代码文件后，mason 自动安装 LSP 服务器与格式化工具（右下角有进度，首次较慢）
3. treesitter 解析器编译需要 C 编译器 + tree-sitter CLI（Windows 上另设 `CC=gcc`）；完整环境依赖见 [nvim/README.md](nvim/README.md)

## 文档

- Neovim 键位与插件总览：[nvim/README.md](nvim/README.md)
- tmux 键位与文件职责：[tmux/README.md](tmux/README.md)

## 插件版本策略

`lazy-lock.json` 锁定了全部插件的 commit。新机器首次启动会自动安装同一批版本；日常不要随手 `:Lazy update`——升级流程是：升级 → 实测 → 提交新锁文件，出问题用 `:Lazy restore` 一键回滚。
