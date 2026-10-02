return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    -- 超大文件（minified/生成代码）跳过 sign/blame，避免卡顿
    max_file_length = 5000,
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    on_attach = function(bufnr)
      local gs = require 'gitsigns'

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = 'Git: ' .. desc })
      end

      -- hunk 跳转
      map('n', '<leader>gn', gs.next_hunk, 'next hunk')
      map('n', '<leader>gp', gs.prev_hunk, 'prev hunk')
      map('n', ']h', gs.next_hunk, 'next hunk')
      map('n', '[h', gs.prev_hunk, 'prev hunk')
      map('n', '<leader>gP', gs.preview_hunk, 'preview hunk')

      -- 暂存（对已暂存的 hunk 再按 stage 即取消暂存，
      -- undo_stage_hunk 已被上游弃用）
      map('n', '<leader>gs', gs.stage_hunk, 'stage/unstage hunk')
      map('v', '<leader>gs', function()
        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'stage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'reset hunk')
      map('v', '<leader>gr', function()
        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, 'reset hunk')
      map('n', '<leader>gu', gs.reset_buffer_index, 'unstage buffer')
      map('n', '<leader>gb', gs.stage_buffer, 'stage buffer')

      -- blame / diff
      map('n', '<leader>gl', gs.toggle_current_line_blame, 'toggle line blame')
      map('n', '<leader>gd', gs.diffthis, 'diff vs index')
      map('n', '<leader>gD', function()
        gs.diffthis '~'
      end, 'diff vs HEAD')

      -- hunk 文本对象: dih / yih / cih
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'inner hunk')
    end,
  },
}
