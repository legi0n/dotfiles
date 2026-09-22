local languages = require("util.languages")

return {
    { "j-hui/fidget.nvim", opts = {} },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local sev = vim.diagnostic.severity
            vim.diagnostic.config({
                severity_sort = true,
                underline = { severity = sev.ERROR },
                float = { border = "rounded", source = "if_many" },
                virtual_text = { source = "if_many", spacing = 2 },
                signs = {
                    text = {
                        [sev.ERROR] = "",
                        [sev.WARN] = "",
                        [sev.INFO] = "",
                        [sev.HINT] = "",
                    },
                },
            })

            -- Applied to every server
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })

            -- Per-server settings from util/languages.lua
            local servers = languages.servers()
            for name, opts in pairs(servers) do
                vim.lsp.config(name, opts)
            end
            vim.lsp.enable(vim.tbl_keys(servers))

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    local buf = event.buf
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if not client then
                        return
                    end

                    local function map(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
                    end

                    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename")
                    map("n", "<leader>cd", vim.lsp.buf.declaration, "Declaration")
                    map("n", "gd", vim.lsp.buf.definition, "Definition")

                    -- Highlight references under the cursor
                    if client:supports_method("textDocument/documentHighlight", buf) then
                        local group = vim.api.nvim_create_augroup("user-lsp-highlight-" .. buf, { clear = true })
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
                        vim.api.nvim_create_autocmd("LspDetach", {
                            group = group,
                            buffer = buf,
                            once = true,
                            callback = function()
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds({ group = group, buffer = buf })
                            end,
                        })
                    end

                    -- Inlay hints toggle
                    if client:supports_method("textDocument/inlayHint", buf) then
                        map("n", "<leader>ch", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }),
                                { bufnr = buf }
                            )
                        end, "Toggle Inlay Hints")
                    end
                end,
            })
        end,
    },
}
