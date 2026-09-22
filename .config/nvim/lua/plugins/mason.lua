local languages = require("util.languages")

return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function()
            return {
                ensure_installed = vim.tbl_keys(languages.servers()),
                automatic_enable = false,
            }
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = function()
            return { ensure_installed = languages.tools() }
        end,
    },
}
