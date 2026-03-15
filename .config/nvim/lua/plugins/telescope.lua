return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
        {
            "<leader>fg",
            function()
                if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") == "true\n" then
                    require("telescope.builtin").git_files()
                else
                    print("Not inside a Git repository")
                end
            end,
            desc = "Find Git Files",
        },
        { "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Find with Grep" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
    },
}
