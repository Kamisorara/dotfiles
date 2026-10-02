-- blink.cmp: 替代 nvim-cmp（hrsh7th 已基本停止维护）
-- 内置 LSP/路径/buffer/片段源与 cmdline 补全，Rust 预编译二进制模糊匹配
return {
  'saghen/blink.cmp',
  version = '1.*',
  -- dashboard 阶段进插入模式/敲命令时自行加载；
  -- 同时被 nvim-lspconfig、lsp-java 声明为 dependency，
  -- 保证 capabilities 在服务器启动（FileType）之前就位
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    -- LuaSnip 钉 v2（官方建议，main 分支未验证）
    { 'L3MON4D3/LuaSnip', version = 'v2.*' },
  },
  opts = {
    appearance = {
      nerd_font_variant = 'mono',
    },
    keymap = {
      preset = 'default',
      -- 保持 nvim-cmp 的肌肉记忆：C-Space 手动补全，CR 确认
      -- Tab/S-Tab 由 default 预设绑到 snippet_forward/backward，
      -- 同时解决了 LuaSnip 占位符跳转没有键位的问题
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<CR>'] = { 'accept', 'fallback' },
    },
    snippets = { preset = 'luasnip' },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    completion = {
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
      menu = {
        draw = {
          components = {
            kind_icon = {
              ellipsis = false,
              text = function(ctx)
                local icon = ctx.kind_icon
                -- 颜色值在补全菜单里显示色块；colorizer 按 ft 懒加载，
                -- 未加载的文件类型里 pcall 失败走默认图标
                local ok, hlc = pcall(require, 'nvim-highlight-colors')
                if ok and ctx.item.source_name == 'LSP' then
                  local color_item =
                    hlc.format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item.abbr then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local highlight = 'BlinkCmpKind' .. ctx.kind
                local ok, hlc = pcall(require, 'nvim-highlight-colors')
                if ok and ctx.item.source_name == 'LSP' then
                  local color_item =
                    hlc.format(ctx.item.documentation, { kind = ctx.kind })
                  if color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end,
            },
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
    cmdline = {
      keymap = { preset = 'inherit' },
      completion = {
        menu = {
          -- 只在命令行(:)和搜索(/)时自动弹出，输入模式保持原生
          auto_show = function()
            local t = vim.fn.getcmdtype()
            return t == ':' or t == '/'
          end,
        },
      },
    },
  },
  config = function(_, opts)
    require('blink.cmp').setup(opts)

    -- snippets：跟随配置目录（symlink/junction 后即本仓库的 snippets/），
    -- 不用写死 ~/.config 路径，Windows 上也能找到
    require('luasnip.loaders.from_vscode').load {
      paths = { vim.fn.stdpath 'config' .. '/snippets' },
    }
  end,
}
