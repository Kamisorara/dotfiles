return {
  'nvimdev/dashboard-nvim',
  lazy = false,
  opts = {
    theme = 'doom',
    config = {
      -- https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow&t=AtlasVim
      header = {
        ' ',
        ' █████╗ ████████╗██╗      █████╗ ███████╗██╗   ██╗██╗███╗   ███╗',
        '██╔══██╗╚══██╔══╝██║     ██╔══██╗██╔════╝██║   ██║██║████╗ ████║',
        '███████║   ██║   ██║     ███████║███████╗██║   ██║██║██╔████╔██║',
        '██╔══██║   ██║   ██║     ██╔══██║╚════██║╚██╗ ██╔╝██║██║╚██╔╝██║',
        '██║  ██║   ██║   ███████╗██║  ██║███████║ ╚████╔╝ ██║██║ ╚═╝ ██║',
        '╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝',
        ' ',
      },
      center = {
        {
          icon = '󰱽 ',
          desc = 'Find File',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          icon = '󰊄 ',
          desc = 'Find Word',
          action = 'Telescope live_grep',
          key = 'w',
        },
        {
          icon = '󰄉 ',
          desc = 'Recent Files',
          action = 'Telescope oldfiles',
          key = 'r',
        },
        {
          icon = '  ',
          desc = 'Lazy Profile',
          action = 'Lazy profile',
        },
        {
          icon = '  ',
          desc = 'Mason',
          action = 'Mason',
        },
      },
      footer = {
        '🧊🧊🧊 Hope that you enjoy using AtlasVim 🧊🧊🧊',
      },
    },
  },
  config = function(_, opts)
    require('dashboard').setup(opts)
  end,
}
