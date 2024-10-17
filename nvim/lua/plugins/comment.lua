return {
  'numToStr/Comment.nvim',
  main = 'Comment',
  version = 'v0.8.0',
  opts = {
    mappings = { basic = true, extra = true, extended = false },
  },
  config = function(_, opts)
    require('Comment').setup(opts)

    -- Remove the keymap defined by Comment.nvim
    vim.keymap.del('n', 'gcc')
    vim.keymap.del('n', 'gbc')
    vim.keymap.del('n', 'gc')
    vim.keymap.del('n', 'gb')
    vim.keymap.del('x', 'gc')
    vim.keymap.del('x', 'gb')
    vim.keymap.del('n', 'gcO')
    vim.keymap.del('n', 'gco')
    vim.keymap.del('n', 'gcA')
  end,
  keys = function()
    local vvar = vim.api.nvim_get_vvar
    local api = require 'Comment.api'

    local toggle_current_line = function()
      if vvar 'count' == 0 then
        return '<Plug>(comment_toggle_linewise_current)'
      else
        return '<Plug>(comment_toggle_linewise_count)'
      end
    end

    local toggle_current_block = function()
      if vvar 'count' == 0 then
        return '<Plug>(comment_toggle_blockwise_current)'
      else
        return '<Plug>(comment_toggle_blockwise_count)'
      end
    end

    return {
      {
        '<leader>c',
        '<Plug>(comment_toggle_linewise)',
        desc = 'comment toggle linewise',
      },
      {
        '<leader>ca',
        '<Plug>(comment_toggle_blockwise)',
        desc = 'comment toggle blockwise',
      },
      {
        '<leader>cc',
        toggle_current_line,
        expr = true,
        desc = 'comment toggle current line',
      },
      {
        '<leader>cb',
        toggle_current_block,
        expr = true,
        desc = 'comment toggle current block',
      },
      {
        '<leader>cc',
        '<Plug>(comment_toggle_linewise_visual)',
        mode = 'x',
        desc = 'comment toggle linewise',
      },
      {
        '<leader>cb',
        '<Plug>(comment_toggle_blockwise_visual)',
        mode = 'x',
        desc = 'comment toggle blockwise',
      },
      {
        '<leader>co',
        api.insert.linewise.below,
        desc = 'comment insert below',
      },
      {
        '<leader>cO',
        api.insert.linewise.above,
        desc = 'comment insert above',
      },
      {
        '<leader>cA',
        api.locked 'insert.linewise.eol',
        desc = 'comment insert end of line',
      },
    }
  end,
}
