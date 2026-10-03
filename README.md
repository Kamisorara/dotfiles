# dotfiles

个人配置仓库：zsh（Zim）、Neovim（lazy.nvim）、tmux，以及 Windows 侧 PowerShell 7 的提示符（oh-my-posh）。

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
- tmux / zsh 不适用于 Windows，跳过；PowerShell 提示符的安装配置见下方「PowerShell 7 提示符（Windows）」

### 首次启动

1. 第一次打开 Neovim 会自动 bootstrap lazy.nvim，并按 `lazy-lock.json` 安装全部插件
2. 打开任意代码文件后，mason 自动安装 LSP 服务器与格式化工具（右下角有进度，首次较慢）
3. treesitter 解析器编译需要 C 编译器 + tree-sitter CLI（Windows 上另设 `CC=gcc`）；完整环境依赖见 [nvim/README.md](nvim/README.md)

## PowerShell 7 提示符（Windows）

Windows 侧用 [oh-my-posh](https://ohmyposh.dev) 做 PowerShell 7 的提示符主题。配置只有一行，在 pwsh 的 `$PROFILE`（本机是 `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`，不在仓库内）。

### 安装

scoop / winget 二选一，都是用户级安装，装完**重开终端**让 PATH 和环境变量生效：

```powershell
# scoop（本机直连 GitHub 不通，winget 下载会报 0x80072efd，需临时挂本机代理）
scoop config proxy 127.0.0.1:7897   # Clash 系默认混合端口，需代理软件在运行
scoop install oh-my-posh
scoop config rm proxy

# 或 winget（网络可达 GitHub 时）
winget install JanDeDobbeleer.OhMyPosh -s winget
```

scoop 安装时会写入用户环境变量 `POSH_THEMES_PATH`（主题目录）；升级用 `scoop update oh-my-posh`，主题随之更新。

### 字体

提示符图标依赖 Nerd Font。本机已装 JetBrainsMono（Nerd Font v3 新命名，家族名为 `JetBrainsMono NF` / `NFM` / `NFP`，无连字变体是 `JetBrainsMonoNL *`），Windows Terminal 各 profile 的 `font.face` 应配 **`JetBrainsMono NFM`**（等宽图标版）。注意旧命名 `JetBrainsMono Nerd Font Mono` 匹配不到任何已装字体，会导致图标显示为方块。新机器没装字体时：

```powershell
oh-my-posh font install JetBrainsMono   # 从 GitHub 下载，网络不通时同上挂代理
```

### 配置 $PROFILE

```powershell
notepad $PROFILE   # 文件不存在时先 New-Item -Path $PROFILE -Type File -Force
```

加入一行：

```powershell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
```

- 换主题：pwsh 里跑 `Get-PoshThemes` 预览全部主题（渲染较慢，属正常），挑好后替换配置里的文件名
- psmux 里提示符"没生效"：psmux 面板的 shell 虽以 `-NoProfile` 拉起，但 psmux 会自行 dot-source 全部 profile，配置本身是生效的；问题出在 psmux 的 server 和预热（warm）pane 是**常驻的**——改 `$PROFILE` 或装完新工具后，已存在的 pane 不会重新加载。在旧 pane 里执行 `respawn-pane`，或 `psmux kill-server` 后重开（会结束现存 session）；也别从装新工具之前就开着的旧终端窗口启动 psmux，pane 会继承旧环境变量
- 只配了 pwsh 7；Windows PowerShell 5.1 没配（它默认禁止执行 profile 脚本，需先 `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`，不建议）
- 若要多机同步，可把 profile 收进仓库再做 Junction（同 nvim 的做法）

## 文档

- Neovim 键位与插件总览：[nvim/README.md](nvim/README.md)
- tmux 键位与文件职责：[tmux/README.md](tmux/README.md)

## 插件版本策略

`lazy-lock.json` 锁定了全部插件的 commit。新机器首次启动会自动安装同一批版本；日常不要随手 `:Lazy update`——升级流程是：升级 → 实测 → 提交新锁文件，出问题用 `:Lazy restore` 一键回滚。
