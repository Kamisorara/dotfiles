return {
  'mfussenegger/nvim-jdtls',
  ft = 'java',
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local jdtls = require 'jdtls'
    local home = os.getenv 'HOME'

    -- 工作区配置路径
    local workspace_root = home .. '/.cache/jdtls-workspace'

    -- Mason 安装的 jdtls 路径
    local jdtls_install = vim.fn.glob(home .. '/.local/share/nvim/mason/packages/jdtls')

    local config = {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-jar',
        vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        jdtls_install .. '/config_mac',
        '-data',
        workspace_root,
      },
      root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
      settings = {
        java = {
          signatureHelp = { enabled = true },
          completion = {
            favoriteStaticMembers = {
              'org.junit.Assert.*',
              'org.junit.Assume.*',
              'org.junit.jupiter.api.Assertions.*',
            },
          },
          contentProvider = { preferred = 'fernflower' },
        },
      },
      init_options = {
        bundles = {},
      },
    }

    jdtls.start_or_attach(config)
  end,
}
