# AGENTS.md

Personal dotfiles: zsh (Zim plugin manager), Neovim (lazy.nvim), and tmux configs. There is no build system, package manager, or test suite — changes are verified by launching Neovim/tmux on the target machine.

## Layout & deployment

- `.zimrc` — Zim module list for zsh (comments in Chinese).
- `nvim/` — Neovim config, requires Neovim >= 0.10.
  - `init.lua` bootstraps lazy.nvim, then loads `lua/base.lua` (options), `lua/keymap.lua` (global maps) and `lua/transparent.lua` (native background transparency), then `require('lazy').setup('plugins')`.
  - `lua/plugins/` — one file per plugin, each returning a lazy.nvim spec table; auto-loaded by lazy.nvim.
  - `lazy-lock.json` — pinned plugin versions (commit after plugin changes).
  - `snippets/` — VS Code-style JSON snippets loaded via LuaSnip.
  - `stylua.toml` — repo Lua style: 80-col width, 2-space indent, prefer single quotes, no call parentheses.
- `tmux/` — `tmux.conf` sources `statusline.conf`, `utility.conf`, and (on macOS only) `macos.conf`.
- Windows pwsh 7 prompt is oh-my-posh (installed via scoop). The profile lives at `Documents\PowerShell\Microsoft.PowerShell_profile.ps1`, NOT in this repo; install/config reference is the「PowerShell 7 提示符（Windows）」section in `README.md`.
- Deployed via symlinks: Unix uses `~/.config/nvim -> dotfiles/nvim` and `~/.config/tmux -> dotfiles/tmux`; this Windows machine uses a junction `%LOCALAPPDATA%\nvim -> dotfiles/nvim`. Full per-OS setup instructions live in `README.md`. Configs target Unix paths even though this repo may be edited on Windows.

## Conventions

- Lua: follow stylua.toml (run `stylua <file>` to format). Comments are mixed Chinese/English; Chinese is fine.
- Adding a plugin: create a new file in `lua/plugins/` named after the plugin, returning a lazy spec; prefer lazy loading (`event = 'VeryLazy'`, `keys`, `ft`, or `cmd`).
- Adding an LSP server: add to `ensure_installed` in `lua/plugins/mason.lua` and configure with `vim.lsp.config(...)` + `vim.lsp.enable {...}` in `lua/plugins/lspconfig.lua` (0.11+ API).
- Adding a formatter: add to mason `ensure_installed` plus `formatters_by_ft` in `lua/plugins/conform.lua` (format-on-save is the only formatting entry point).
- Linting: `lua/plugins/lint.lua` wires nvim-lint + eslint_d for js/ts/jsx/tsx/vue; it only runs when the project has an eslint config (flat or legacy). Python formatting is ruff (conform); Python linting is the ruff LSP server (pyright stays for type checking).
- Leader key is `<Space>` in Neovim; tmux prefix is `C-f` (default `C-b` is unbound). Git keymaps live under `<leader>g` (gitsigns in `gitsigns.lua`, diffview + telescope git pickers in their own specs, permalink yank/open in `gitlinker.lua`). Merge-conflict resolution (`co`/`ct`/`cb`/`c0`) is `git-conflict.lua`.

## Gotchas

- `lazy.nvim` auto-update and change detection are intentionally disabled in `init.lua` — do not re-enable. After changing plugin specs, run `:Lazy clean` + `:Lazy update` (or `restore`) on the target machine to sync `lazy-lock.json`; the lock may still reference removed plugins until then.
- `nvim-treesitter` is pinned to the rewritten **`main` branch**: install parsers with `require('nvim-treesitter').install {}`, enable highlighting with `vim.treesitter.start()` (wired via a `FileType` autocmd). The legacy `require('nvim-treesitter.configs')` API does not exist — do not reintroduce it. Incremental selection was removed upstream. Building parsers requires the **tree-sitter CLI** (`npm i -g tree-sitter-cli`) plus a C compiler (on Windows also set `CC=gcc`; parsers land in `stdpath('data')/site/parser`).
- Formatting goes **only** through `conform.nvim` (`format_on_save` with `lsp_format = 'fallback'`). none-ls/null-ls was removed — do not add it back.
- TypeScript/JS LSP is **vtsls + vue_ls** (plus the `@vue/typescript-plugin` global plugin for vtsls). `typescript-tools.nvim` was removed on purpose; `<leader>m`/`<leader>a` (organize/add imports) now go through vtsls code actions in `lspsaga.lua`.
- `vim.lsp.enable` takes a single name or a table of names, never multiple string arguments (this was a real bug once).
- mason specs use the `mason-org/*` repos (renamed from `williamboman/*`).
- `which-key.lua` uses the **v3 API** (`wk.add { { '<leader>x', group = '...' } }`), not the old `wk.register`.
- Scrolling uses Neovim's native `smoothscroll` (`base.lua`); background transparency is the native module `lua/transparent.lua` (`:TransparentToggle` to switch). neoscroll.nvim, nvim-notify (archived) and nvim-transparent (unmaintained since 2022) were removed on purpose — don't re-add them.
- `nvim-tree` is pinned to `v1.18.0` (upgraded from `v1.11.0`). v1.18 renamed `update_focused_file.update_cwd` → `update_root = { enable = true }` and `api.config.mappings.default_on_attach` → `api.map.on_attach.default` (both already migrated). `filters.custom`/`filters.exclude` keep their v1.11 semantics (Vim-regex matched against relpath/basename); when bumping again, check `:h nvim-tree-opts`.
- Java LSP runs via nvim-jdtls in `lua/plugins/lsp-java.lua` (per-project workspace dirs under `stdpath('data')/jdtls-workspaces`; skipped when no project root is found). mason-lspconfig `automatic_enable` is off so lspconfig's `jdtls` never double-starts — every server that should auto-attach must be listed in the `vim.lsp.enable` table in `lspconfig.lua`.
- mason.nvim and nvim-lspconfig load on `BufReadPre`/`BufNewFile` (NOT VeryLazy): mason.setup() prepends `mason/bin` to PATH, and BufReadPre is the last event that still fires before a buffer's FileType triggers `vim.lsp.enable` spawns. Moving them to VeryLazy races the first buffer's LSP startup against PATH injection.
- Completion is **blink.cmp** (nvim-cmp and all cmp-* sources/lspkind were removed on purpose — don't re-add). LuaSnip stays as the snippet engine (pinned `v2.*`). blink is declared a dependency of nvim-lspconfig and lsp-java so `get_lsp_capabilities()` is available before servers start. hop.nvim and vim-surround were replaced by flash.nvim (`<leader>hp`/`<leader>hs`) and nvim-surround (same ys/cs/ds); trouble.nvim lives under `<leader>d`.
- `nvim/CLAUDE.md` (gitignored, local-only) is outdated — trust the code and git log over it.
- `*.lua.bak` files (e.g. `tailwind-tools.lua.bak`) are disabled configs kept intentionally; don't delete or "restore" them.
- GitHub over HTTPS is unreachable directly on this machine (winget downloads fail with `0x80072efd`); git uses SSH so it is unaffected. For HTTP downloads (scoop/winget/curl/npm), go through the local proxy `http://127.0.0.1:7897` (Clash mixed port — only works while the proxy app is running), e.g. `scoop config proxy 127.0.0.1:7897` … `scoop config rm proxy`.

## Docs to read before editing

- `nvim/README.md` — full keymap and plugin reference (Chinese).
- `tmux/README.md` — tmux key bindings and file roles.
- `README.md` — per-OS deployment plus the Windows PowerShell 7 / oh-my-posh setup (Chinese).
