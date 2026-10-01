# AGENTS.md

Personal dotfiles: zsh (Zim plugin manager), Neovim (lazy.nvim), and tmux configs. There is no build system, package manager, or test suite — changes are verified by launching Neovim/tmux on the target machine.

## Layout & deployment

- `.zimrc` — Zim module list for zsh (comments in Chinese).
- `nvim/` — Neovim config, requires Neovim >= 0.10.
  - `init.lua` bootstraps lazy.nvim, then loads `lua/base.lua` (options) and `lua/keymap.lua` (global maps), then `require('lazy').setup('plugins')`.
  - `lua/plugins/` — one file per plugin, each returning a lazy.nvim spec table; auto-loaded by lazy.nvim.
  - `lazy-lock.json` — pinned plugin versions (commit after plugin changes).
  - `snippets/` — VS Code-style JSON snippets loaded via LuaSnip.
  - `stylua.toml` — repo Lua style: 80-col width, 2-space indent, prefer single quotes, no call parentheses.
- `tmux/` — `tmux.conf` sources `statusline.conf`, `utility.conf`, and (on macOS only) `macos.conf`.
- Deployed via symlinks: `~/.config/nvim -> dotfiles/nvim`, `~/.config/tmux -> dotfiles/tmux`. Configs target Unix paths even though this repo may be edited on Windows.

## Conventions

- Lua: follow stylua.toml (run `stylua <file>` to format). Comments are mixed Chinese/English; Chinese is fine.
- Adding a plugin: create a new file in `lua/plugins/` named after the plugin, returning a lazy spec; prefer lazy loading (`event = 'VeryLazy'`, `keys`, `ft`, or `cmd`).
- Adding an LSP server: add to `ensure_installed` in `lua/plugins/mason.lua` and configure with `vim.lsp.config(...)` + `vim.lsp.enable {...}` in `lua/plugins/lspconfig.lua` (0.11+ API).
- Adding a formatter: add to mason `ensure_installed` plus `formatters_by_ft` in `lua/plugins/conform.lua` (format-on-save is the only formatting entry point).
- Leader key is `<Space>` in Neovim; tmux prefix is `C-f` (default `C-b` is unbound). Git keymaps live under `<leader>g` (gitsigns in `gitsigns.lua`, diffview + telescope git pickers in their own specs).

## Gotchas

- `lazy.nvim` auto-update and change detection are intentionally disabled in `init.lua` — do not re-enable. After changing plugin specs, run `:Lazy clean` + `:Lazy update` (or `restore`) on the target machine to sync `lazy-lock.json`; the lock may still reference removed plugins until then.
- `nvim-treesitter` is pinned to the rewritten **`main` branch**: install parsers with `require('nvim-treesitter').install {}`, enable highlighting with `vim.treesitter.start()` (wired via a `FileType` autocmd). The legacy `require('nvim-treesitter.configs')` API does not exist — do not reintroduce it. Incremental selection was removed upstream. Building parsers requires the **tree-sitter CLI** (`npm i -g tree-sitter-cli`) plus a C compiler (on Windows also set `CC=gcc`; parsers land in `stdpath('data')/site/parser`).
- Formatting goes **only** through `conform.nvim` (`format_on_save` with `lsp_format = 'fallback'`). none-ls/null-ls was removed — do not add it back.
- TypeScript/JS LSP is **vtsls + vue_ls** (plus the `@vue/typescript-plugin` global plugin for vtsls). `typescript-tools.nvim` was removed on purpose; `<leader>m`/`<leader>a` (organize/add imports) now go through vtsls code actions in `lspsaga.lua`.
- `vim.lsp.enable` takes a single name or a table of names, never multiple string arguments (this was a real bug once).
- mason specs use the `mason-org/*` repos (renamed from `williamboman/*`).
- `which-key.lua` uses the **v3 API** (`wk.add { { '<leader>x', group = '...' } }`), not the old `wk.register`.
- Scrolling uses Neovim's native `smoothscroll` (`base.lua`); neoscroll.nvim and nvim-notify were removed for a lighter setup — don't re-add casually.
- `nvim-tree` is pinned to `v1.11.0`; when bumping, check `:h nvim-tree-opts-filters` — `filters.custom` may be renamed in newer versions.
- Java LSP support was removed; `nvim/CLAUDE.md` (gitignored, local-only) still mentions it and is outdated — trust the code and git log over it.
- `*.lua.bak` files (e.g. `tailwind-tools.lua.bak`) are disabled configs kept intentionally; don't delete or "restore" them.

## Docs to read before editing

- `nvim/README.md` — full keymap and plugin reference (Chinese).
- `tmux/README.md` — tmux key bindings and file roles.
