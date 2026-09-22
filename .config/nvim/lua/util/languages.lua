local M = {}

M.languages = {
    lua = {
        filetypes = { "lua" },
        detect = { "lua" },
        server = "lua_ls",
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                completion = { callSnippet = "Replace" },
            },
        },
        formatters = { "stylua" },
    },
    python = {
        filetypes = { "python" },
        detect = { "python3", "python" },
        server = "pyright",
        formatters = { "black", "isort" },
    },
    c = {
        filetypes = { "c", "cpp" },
        detect = { "clang", "gcc" },
        server = "clangd",
        formatters = { "clang-format" },
    },
    java = {
        filetypes = { "java" },
        detect = { "javac" },
        server = "jdtls",
        formatters = { "google-java-format" },
    },
    typescript = {
        filetypes = { "javascript", "typescript" },
        detect = { "tsc", "bun", "node" },
        server = "ts_ls",
        formatters = { "prettier" },
    },
    web = {
        filetypes = { "json", "markdown", "html", "css" },
        formatters = { "prettier" },
    },
}

M.formatter_opts = {
    ["clang-format"] = {
        prepend_args = { "--style", "{IndentWidth: 4, TabWidth: 4, UseTab: Never}" },
    },
    ["google-java-format"] = {
        prepend_args = { "--aosp" },
    },
    ["prettier"] = {
        prepend_args = { "--tab-width", "4", "--use-tabs", "false" },
    },
}

local function has_any_cmd(cmds)
    if not cmds or #cmds == 0 then
        return true
    end
    for _, cmd in ipairs(cmds) do
        if vim.fn.executable(cmd) == 1 then
            return true
        end
    end
    return false
end

local function enabled()
    local out = {}
    for name, lang in pairs(M.languages) do
        if has_any_cmd(lang.detect) then
            out[name] = lang
        end
    end
    return out
end

function M.servers()
    local servers = {}
    for _, lang in pairs(enabled()) do
        if lang.server then
            servers[lang.server] = { settings = lang.settings or {} }
        end
    end
    return servers
end

function M.tools()
    local seen, tools = {}, {}
    local function add(t)
        if not seen[t] then
            seen[t] = true
            table.insert(tools, t)
        end
    end
    for _, lang in pairs(enabled()) do
        vim.tbl_map(add, lang.formatters or {})
        vim.tbl_map(add, lang.extra_tools or {})
    end
    table.sort(tools)
    return tools
end

function M.formatters_by_ft()
    local out = {}
    for _, lang in pairs(M.languages) do
        for _, ft in ipairs(lang.filetypes or {}) do
            out[ft] = lang.formatters
        end
    end
    return out
end

return M
