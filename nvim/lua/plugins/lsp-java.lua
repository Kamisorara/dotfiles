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

    -- 根目录决定导入范围，多模块工程必须取最外层根，层级不限：
    --   - Gradle: settings.gradle(.kts) 定义多模块根，一路向上探到最顶层
    --     （复合构建 composite build 的内嵌 build 也有 settings.gradle，
    --     取最外层才能连同 included build 一起导入）
    --   - Maven:  先找最近的 pom.xml（可能是子模块），再沿「连续 pom 链」
    --     逐层上溯到 reactor 根，层数不限；文件常在 src/main/java 深处，
    --     不能从文件目录直接开始判 pom。只导入某个子模块会导致兄弟模块
    --     全部 unresolved
    --   - 其余:   按原标记就近找
    local function find_root()
      local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
      local top_settings = nil
      while dir and dir ~= '' do
        if
          vim.fn.filereadable(dir .. '/settings.gradle') == 1
          or vim.fn.filereadable(dir .. '/settings.gradle.kts') == 1
        then
          top_settings = dir
        end
        local parent = vim.fs.dirname(dir)
        if not parent or parent == dir then
          break
        end
        dir = parent
      end
      if top_settings then
        return top_settings
      end
      local nearest_pom = vim.fs.root(0, { 'pom.xml' })
      if nearest_pom then
        local dir = nearest_pom
        while dir do
          local parent = vim.fs.dirname(dir)
          if not parent or parent == dir then
            break
          end
          if vim.fn.filereadable(parent .. '/pom.xml') == 0 then
            break
          end
          dir = parent
        end
        return dir
      end
      return vim.fs.root(0, {
        'build.gradle',
        'build.gradle.kts',
        'mvnw',
        'gradlew',
        '.git',
      })
    end

    local root_dir = find_root()

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
