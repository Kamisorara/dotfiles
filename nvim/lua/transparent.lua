-- 原生背景透明，替代已停更的 xiyaowong/nvim-transparent
-- 原理：清掉指定高亮组的背景色（fg 等前景属性保留）
local M = {}

M.enabled = true

-- 高亮组清单与原插件默认组一致（LineNr / CursorLine 保留背景以保证可读性）
local groups = {
  'Normal',
  'NormalNC',
  'NonText',
  'EndOfBuffer',
  'SignColumn',
  'CursorLineNr',
  'StatusLine',
  'StatusLineNC',
  -- 兼容其他配色：语法组也可能带背景
  'Comment',
  'Constant',
  'Special',
  'Identifier',
  'Statement',
  'PreProc',
  'Type',
  'Underlined',
  'Todo',
  'String',
  'Function',
  'Conditional',
  'Repeat',
  'Operator',
  'Structure',
  -- 文件树（原 extra_groups）
  'NvimTreeNormal',
  'NvimTreeNormalNC',
}

local function clear()
  if not M.enabled then
    return
  end
  for _, name in ipairs(groups) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, create = false })
    if ok and type(hl) == 'table' and (hl.bg or hl.ctermbg) then
      hl.bg = nil
      hl.ctermbg = nil
      pcall(vim.api.nvim_set_hl, 0, name, hl)
    end
  end
end

M.clear = function()
  clear()
  -- 晚加载的插件会重新定义高亮，延迟补清
  vim.defer_fn(clear, 500)
  vim.defer_fn(clear, 2000)
end

local augroup = vim.api.nvim_create_augroup('UserTransparent', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
  group = augroup,
  callback = clear,
})

vim.api.nvim_create_autocmd({ 'VimEnter', 'FileType' }, {
  group = augroup,
  callback = clear,
})

vim.api.nvim_create_user_command('TransparentToggle', function()
  M.enabled = not M.enabled
  if M.enabled then
    M.clear()
  elseif vim.g.colors_name then
    -- 重新应用配色以恢复背景
    vim.cmd.colorscheme(vim.g.colors_name)
  end
end, { desc = '切换背景透明' })

return M
