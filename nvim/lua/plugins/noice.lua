return {
  'folke/noice.nvim',
  -- 不钉 tag：v4.10.0 是最后一个 release（2025-02），落后 main 19 个修复
  -- （signature help autocmd 性能重构、markdown/notify 渲染修复等），跟 main
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    -- vim.notify 走内置 mini 弹窗（右下角，约 2 秒自动消失）。
    -- 默认的 notify 视图以 nvim-notify 为后端，本配置不装它（已停更），
    -- 缺后端时所有通知会被静默丢弃
    notify = {
      view = 'mini',
    },
    messages = {
      enabled = false, -- enables the Noice messages UI
      view = 'notify', -- default view for messages
      view_error = 'notify', -- view for errors
      view_warn = 'notify', -- view for warnings
      view_history = 'messages', -- view for :messages
      view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
    },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
}
