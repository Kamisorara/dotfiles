return {
  {
    'github/copilot.vim',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      debug = true,
      window = {
        layout = 'float',
        border = 'rounded',
        title = 'Copilot Chat',
        width = 0.8, -- 80% of editor width
        height = 0.8, -- 80% of editor height
        x = 0.5, -- centered
        y = 0.5, -- centered
      },
      model = 'claude-3.7-sonnet',
      question_header = '  User ',
      answer_header = '  Copilot ',
      error_header = '  Error ',
      auto_insert_mode = true,
      insert_at_end = true,
      context = 'buffers',
      highlight_selection = false,
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      -- Initialize CopilotChat with the options
      chat.setup(opts)

      local wk = require 'which-key'
      wk.register({
        ['<leader>j'] = {
          name = 'Copilot',
          c = { '<cmd>CopilotChat<cr>', 'Open Copilot Chat' },
          e = { '<cmd>CopilotChatExplain<cr>', 'Explain Code' },
          t = { '<cmd>CopilotChatTests<cr>', 'Generate Tests' },
          f = { '<cmd>CopilotChatFix<cr>', 'Fix Code' },
          d = { '<cmd>CopilotChatDocs<cr>', 'Generate Docs' },
        },
      }, { mode = 'n', silent = true, noremap = true })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
