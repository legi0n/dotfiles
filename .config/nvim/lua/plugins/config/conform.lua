return {
    notify_on_error = false, -- Do not notify on error
    format_on_save = false,
    formatters_by_ft = {
        -- Formatter settings by filetype
        lua = { "stylua" },
        python = { "black", "isort" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        htmx = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        sql = { "sqlfluff" },
        java = { "google-java-format" },
        tex = { "latexindent" },
    },
    formatters = {
        ["clang-format"] = {
            prepend_args = {
                "--style",
                "{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
            },
        },
        ["prettier"] = {
            prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
        },

        ["latexindent"] = {
            prepend_args = { "-m", "--indent", "4", "--usetab", "0" },
        },

        ["sqlfluff"] = {
            prepend_args = { "--tab_space_size", "4", "--indent_unit", "space" },
        },
    },
}
