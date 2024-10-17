return {
  'xiyaowong/nvim-transparent',
  opts = {
    exclude_groups = {
      -- "LineNr",
      -- "CursorLine",
    }, -- table: groups you don't want to clear
    extra_groups = {
      'NvimTreeNormal',
      'NvimTreeNormalNC',
    },
  },
  config = function(_, opts)
    -- Enable transparent by default
    local transparent_cache = vim.fn.stdpath 'data' .. '/transparent_cache'
    local f = io.open(transparent_cache, 'r')
    if f ~= nil then
      f:close()
    else
      f = io.open(transparent_cache, 'w')
      f:write 'true'
      f:close()
    end

    require('transparent').setup(opts)
  end,
}
