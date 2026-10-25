local rg_args = require("util.ignore_globs").rg_args()

return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
            return vim.fn.executable("make") == 1
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            {
                "<leader>fg",
                function()
                    vim.fn.system("git rev-parse --is-inside-work-tree")
                    if vim.v.shell_error == 0 then
                        require("telescope.builtin").git_files()
                    else
                        vim.notify("Not inside a Git repository", vim.log.levels.WARN)
                    end
                end,
                desc = "Find Git Files",
            },
            { "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Find with Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
            { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep Word Under Cursor" },
            { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume Last Search" },
        },
        opts = {
            pickers = {
                find_files = {
                    find_command = vim.list_extend({ "rg", "--files" }, rg_args),
                },
                grep_string = {
                    additional_args = rg_args,
                },
                live_grep = {
                    additional_args = rg_args,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        config = function(_, opts)
            local telescope = require("telescope")
            opts.extensions["ui-select"] = require("telescope.themes").get_dropdown({})
            telescope.setup(opts)
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
        end,
    },
}
