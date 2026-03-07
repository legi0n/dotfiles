return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
        { "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Find with Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
    }
}
