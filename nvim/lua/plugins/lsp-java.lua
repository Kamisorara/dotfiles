-- nvim-jdtls: Eclipse JDT Language Server（Java LSP）
-- 每个项目使用独立 workspace 目录，避免多个项目的 jdt.ls 状态互相污染
return {
  'mfussenegger/nvim-jdtls',
  ft = { 'java' },
  dependencies = {
    'saghen/blink.cmp', -- 补全 capabilities（jdtls 不走 vim.lsp.enable，需手动传入）
  },
  config = function()
    -- Java LSP 需要 JDK 17+，缺失时友好提示而不是报错
    if vim.fn.executable 'java' == 0 then
      vim.notify(
        'jdtls: 未找到 java（需要 JDK 17+），Java LSP 未启动',
        vim.log.levels.WARN
      )
      return
    end

    local root_dir = vim.fs.root(0, {
      'build.gradle',
      'build.gradle.kts',
      'settings.gradle',
      'settings.gradle.kts',
      'pom.xml',
      'mvnw',
      'gradlew',
      '.git',
    })

    if not root_dir then
      vim.notify(
        'jdtls: 找不到项目根目录（需要 pom.xml / build.gradle / .git 之一），跳过启动',
        vim.log.levels.WARN
      )
      return
    end

    local workspace_dir = vim.fn.stdpath 'data'
      .. '/jdtls-workspaces/'
      .. vim.fs.basename(root_dir)

    -- 找 jdtls 可执行文件：Windows 上 mason 生成 .cmd 包装脚本，
    -- libuv 无法直接 spawn，必须经 cmd.exe 调用；Unix 上直接用 PATH 里的 jdtls
    local function build_cmd()
      if vim.fn.has 'win32' == 1 then
        local mason_cmd = vim.fn.stdpath 'data' .. '/mason/bin/jdtls.cmd'
        if vim.fn.filereadable(mason_cmd) == 1 then
          return { 'cmd.exe', '/c', mason_cmd, '-data', workspace_dir }
        end
      end
      local exe = vim.fn.exepath 'jdtls'
      if exe ~= '' then
        return { exe, '-data', workspace_dir }
      end
      return {
        vim.fn.stdpath 'data' .. '/mason/bin/jdtls',
        '-data',
        workspace_dir,
      }
    end

    local config = {
      cmd = build_cmd(),
      root_dir = root_dir,
      capabilities = require('blink.cmp').get_lsp_capabilities(),
      settings = {
        java = {
          -- 需要指定 JDK 运行时时取消注释：
          -- configuration = {
          --   runtimes = { { name = 'JavaSE-21', path = '/path/to/jdk-21' } },
          -- },
        },
      },
      init_options = {
        bundles = {},
      },
    }

    require('jdtls').start_or_attach(config)

    -- 与 TypeScript 的 <leader>m（整理 imports）保持一致
    vim.keymap.set('n', '<leader>m', require('jdtls').organize_imports, {
      buffer = 0,
      desc = 'organize imports',
    })
  end,
}
