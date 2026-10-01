return {
  'nvimdev/lspsaga.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
  event = 'VeryLazy',
  config = function()
    local keymap = vim.keymap

    require('lspsaga').setup {
      ui = {
        border = 'rounded',
      },
      lightbulb = {
        enable = false,
      },
    }

    local builtin = require 'telescope.builtin'

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }

        -- vtsls: 整理/添加 imports（原 typescript-tools.nvim 的功能）
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client.name == 'vtsls' then
          vim.keymap.set('n', '<leader>m', function()
            vim.lsp.buf.code_action {
              context = { only = { 'source.organizeImports' }, diagnostics = {} },
              apply = true,
            }
          end, { buffer = ev.buf, desc = 'organize imports' })
          vim.keymap.set('n', '<leader>a', function()
            vim.lsp.buf.code_action {
              context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} },
              apply = true,
            }
          end, { buffer = ev.buf, desc = 'add missing imports' })
        end

        vim.keymap.set(
          'n',
          '<leader>ld',
          '<cmd>Lspsaga goto_definition<cr>',
          opts
        )
        vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
        vim.keymap.set(
          { 'n', 'v' },
          '<leader>lc',
          '<cmd>Lspsaga code_action<cr>',
          opts
        )
        vim.keymap.set('n', 'gr', builtin.lsp_references, opts)
        vim.keymap.set(
          'n',
          '<space>lk',
          '<cmd>Lspsaga hover_doc<cr>',
          { silent = true }
        )
        vim.keymap.set('n', '<leader>lh', ':Lspsaga hover_doc<CR>')
        vim.keymap.set('n', '<leader>lR', ':Lspsaga lsp_finder<CR>')
        vim.keymap.set(
          'n',
          '<leader>li',
          ':lua vim.lsp.buf.implementation()<CR>'
        )
        vim.keymap.set('n', '<leader>lP', ':Lspsaga show_line_diagnostics<CR>')
        vim.keymap.set('n', '<leader>ln', ':Lspsaga diagnostic_jump_next<CR>')
        vim.keymap.set('n', '<leader>lp', ':Lspsaga diagnostic_jump_prev<CR>')
        vim.keymap.set('n', '<leader>ly', ':Lspsaga yank_line_diagnostics<CR>')
        vim.keymap.set('n', '<leader>o', ':Lspsaga outline<CR>')
      end,
    })
  end,
}
