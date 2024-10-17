return {
   "lewis6991/gitsigns.nvim",
   version="v0.9.0",
    event = "BufEnter",
    main = "gitsigns",
    opts = {},
    keys = {
        { "<leader>gn", ":Gitsigns next_hunk<CR>", desc = "next hunk", silent = true, noremap = true },
        { "<leader>gp", ":Gitsigns prev_hunk<CR>", desc = "prev hunk", silent = true, noremap = true },
        { "<leader>gP", ":Gitsigns preview_hunk<CR>", desc = "preview hunk", silent = true, noremap = true },
        { "<leader>gs", ":Gitsigns stage_hunk<CR>", desc = "stage hunk", silent = true, noremap = true },
        { "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", desc = "undo stage", silent = true, noremap = true },
        { "<leader>gr", ":Gitsigns reset_hunk<CR>", desc = "reset hunk", silent = true, noremap = true },
        { "<leader>gb", ":Gitsigns stage_buffer<CR>", desc = "stage buffer", silent = true, noremap = true },
    },
}
