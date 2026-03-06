return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "tokyonight-night"
        end
    },
    { "mason-org/mason.nvim", opts = {} },
    { "nvim-tree/nvim-web-devicons", opts = {} },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
        },
        init = function()
            vim.g.undotree_SetFocusWhenToggle = 1
        end
    },
    { "lewis6991/gitsigns.nvim", opts = {} },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
            { "<leader>fG", "<cmd>Telescope live_grep<cr>", desc = "Find with Grep" },
        },
    },
    { "nvim-mini/mini.move", version = "*", opts = {} },
    {
        "nvim-mini/mini.statusline",
        version = "*",
        config = function()
            local statusline = require "mini.statusline"
            statusline.setup({})
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end
    }
}
