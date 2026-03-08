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
        },
    },
}
