return {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
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
    opts = function()
        return {
            defaults = {
                file_ignore_patterns = {
                    "^%.git/",
                    "^%.cache/",
                    "%.o$",
                    "%.a$",
                    "%.out$",
                    "%.class$",
                    "%.pdf$",
                    "%.mkv$",
                    "%.mp4$",
                    "%.zip$",
                },
            },
            pickers = {
                find_files = { hidden = true },
                grep_string = { additional_args = { "--hidden" } },
                live_grep = { additional_args = { "--hidden" } },
            },
            extensions = {
                ["ui-select"] = require("telescope.themes").get_dropdown({}),
            },
        }
    end,
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)
        telescope.load_extension("ui-select")
    end,
}
