local languages = require("util.languages")

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
    opts = function()
        return {
            notify_on_error = false,
            format_on_save = false,
            formatters_by_ft = languages.formatters_by_ft(),
            formatters = languages.formatter_opts,
        }
    end,
}
