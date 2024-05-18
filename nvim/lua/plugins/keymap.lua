local utils = require "plugins.utils"

Kamisora.keymap.plugins = {
    check_icons = { "n", "<leader>ui", utils.check_icons },
    select_colorscheme = { "n", "<C-k><C-t>", utils.select_colorscheme },
    view_configuration = { "n", "<leader>f", utils.view_configuration },
}
