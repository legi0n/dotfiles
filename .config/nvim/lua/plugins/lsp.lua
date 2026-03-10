local config = {
    lua = {
        detect = { "lua" },
        server = "lua_ls",
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
                completion = { callSnippet = "Replace" },
            },
        },
        tools = { "stylua" },
    },
    python = {
        detect = { "python3", "python" },
        server = "pyright",
        tools = { "isort", "black" },
    },
    c = {
        detect = { "clang", "gcc" },
        server = "clangd",
        tools = { "clang-format" },
    },
    java = {
        detect = { "javac" },
        server = "jdtls",
        tools = { "google-java-format" },
    },
    typescript = {
        detect = { "tsc", "bun", "node" },
        server = "ts_ls",
    },
}

local function has_any_cmd(cmds)
    for _, cmd in ipairs(cmds) do
        if vim.fn.executable(cmd) == 1 then
            return true
        end
    end
    return false
end

local servers = {}
local tools = { "prettier" }

for _, lang in pairs(config) do
    if #lang.detect == 0 or has_any_cmd(lang.detect) then
        if lang.server then
            servers[lang.server] = {
                settings = lang.settings or {},
            }
        end
        if lang.tools then
            vim.list_extend(tools, lang.tools)
        end
    end
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "j-hui/fidget.nvim", opts = {} },
        },
        keys = {
            { "<leader>ca", vim.lsp.buf.code_action, mode = { "n", "x" }, desc = "LSP: Code Action" },
            { "<leader>cd", vim.lsp.buf.declaration, desc = "LSP: Declaration" },
            { "<leader>cr", vim.lsp.buf.rename, desc = "LSP: Rename" },
        },
        config = function()
            local lsp_attach_group = vim.api.nvim_create_augroup("lsp-attach", { clear = true })
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_attach_group,
                callback = function(event)
                    local buf = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                        local highlight_group = vim.api.nvim_create_augroup("lsp-highlight-" .. buf, { clear = true })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = buf,
                            group = highlight_group,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = buf,
                            group = highlight_group,
                            callback = vim.lsp.buf.clear_references,
                        })
                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = lsp_attach_group,
                            buffer = buf,
                            callback = function()
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = buf })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function()
            return {
                ensure_installed = vim.tbl_keys(servers),
                handlers = {
                    function(server_name)
                        local server_opts = servers[server_name] or {}
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities =
                            vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
                        server_opts.capabilities =
                            vim.tbl_deep_extend("force", capabilities, server_opts.capabilities or {})
                        require("lspconfig")[server_name].setup(server_opts)
                    end,
                },
            }
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = tools,
        },
    },
}
