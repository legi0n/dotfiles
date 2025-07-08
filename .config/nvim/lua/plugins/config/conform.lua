local function get_fmt(...)
    local available = {}
    for _, fmt in ipairs { ... } do
        if vim.fn.executable(fmt) == 1 then
            table.insert(available, fmt)
        end
    end
    return #available > 0 and available or nil
end

return {
    notify_on_error = false,
    format_on_save = false,
    formatters_by_ft = {
        -- Formatter settings by filetype
        lua = get_fmt "stylua",
        python = get_fmt("black", "isort"),
        c = get_fmt "clang-format",
        cpp = get_fmt "clang-format",
        java = get_fmt "google-java-format",
        javascript = get_fmt "prettier",
        typescript = get_fmt "prettier",
        typescriptreact = get_fmt "prettier",
        javascriptreact = get_fmt "prettier",
        json = get_fmt "prettier",
        yaml = get_fmt "prettier",
        markdown = get_fmt "prettier",
        html = get_fmt "prettier",
        css = get_fmt "prettier",
        scss = get_fmt "prettier",
        less = get_fmt "prettier",
    },
    formatters = {
        -- Custom arguments for each formatter
        ["clang-format"] = {
            prepend_args = {
                "--style",
                "{IndentWidth: 4, TabWidth: 4, UseTab: Never}",
            },
        },
        ["prettier"] = {
            prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
        },
    },
}
