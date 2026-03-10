return {
    "stevearc/conform.nvim",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format Code",
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = false,
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "black", "isort" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            java = { "google-java-format" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            json = { "prettier" },
            markdown = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
        },
        formatters = {
            ["clang-format"] = {
                prepend_args = {
                    "--style",
                    "{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
                },
            },
            ["google-java-format"] = {
                prepend_args = { "--aosp" },
            },
            ["prettier"] = {
                prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
            },
        },
    },
}
