return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>tt", "<cmd>Neotree filesystem toggle left<cr>", "Toggle NeoTree" },
        },
        opts = {
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
            },
            window = {
                width = 30,
            },
        },
    },
}
