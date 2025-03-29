return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    -- keys = {
    --   { '<leader>ch', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
    --   { '<leader>ce', '<cmd>CopilotChatExplain<cr>', desc = 'Explain Code' },
    --   { '<leader>ct', '<cmd>CopilotChatTests<cr>', desc = 'Generate Tests' },
    --   { '<leader>cf', '<cmd>CopilotChatFix<cr>', desc = 'Fix Code' },
    --   { '<leader>cd', '<cmd>CopilotChatDocs<cr>', desc = 'Generate Docs' },
    -- },
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
