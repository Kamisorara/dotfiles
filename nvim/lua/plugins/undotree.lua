return {
  'mbbill/undotree',
  version = 'rel_6.1',
  config = function()
    vim.g.undotree_WindowLayout = 2
    vim.g.undotree_TreeNodeShape = '-'
  end,
  keys = {
    {
      '<leader>uu',
      ':UndotreeToggle<CR>',
      desc = 'undo tree toggle',
      silent = true,
      noremap = true,
    },
  },
}
