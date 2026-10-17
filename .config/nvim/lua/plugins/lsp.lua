local languages = require("util.languages")

local HL_METHOD = "textDocument/documentHighlight"

local function on_attach(ev)
    local buf = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
        return
    end

    local function map(lhs, rhs, desc, mode)
        vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition, "Definition")
    map("gD", vim.lsp.buf.declaration, "Declaration")

    if client:supports_method(HL_METHOD, buf) then
        local group = vim.api.nvim_create_augroup("user-lsp-hl-" .. buf, { clear = true })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = group,
            buffer = buf,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = group,
            buffer = buf,
            callback = vim.lsp.buf.clear_references,
        })
    end

    if client:supports_method("textDocument/inlayHint", buf) then
        map("<leader>ch", function()
            local opts = { bufnr = buf }
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(opts), opts)
        end, "Toggle Inlay Hints")
    end
end

local function on_detach(ev)
    local remaining = vim.lsp.get_clients({ bufnr = ev.buf, method = HL_METHOD })
    remaining = vim.tbl_filter(function(c)
        return c.id ~= ev.data.client_id
    end, remaining)

    if #remaining == 0 then
        vim.api.nvim_buf_call(ev.buf, vim.lsp.buf.clear_references)
        pcall(vim.api.nvim_del_augroup_by_name, "user-lsp-hl-" .. ev.buf)
    end
end

return {
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local sev = vim.diagnostic.severity
            vim.diagnostic.config({
                severity_sort = true,
                underline = { severity = sev.ERROR },
                float = { source = "if_many", border = "rounded" },
                virtual_text = { source = "if_many", spacing = 2 },
                jump = { float = true },
                signs = {
                    text = {
                        [sev.ERROR] = "",
                        [sev.WARN] = "",
                        [sev.INFO] = "",
                        [sev.HINT] = "",
                    },
                },
            })

            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            local servers = languages.servers()
            for name, opts in pairs(servers) do
                vim.lsp.config(name, opts)
            end
            vim.lsp.enable(vim.tbl_keys(servers))

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = on_attach,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
                callback = on_detach,
            })
        end,
    },
}
