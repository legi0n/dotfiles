return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        version = "1.*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        opts = {
            keymap = {
                preset = "default",
                ["<C-n>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-y>"] = { "select_and_accept", "fallback" },
                ["<C-space>"] = { "show", "fallback" },
                ["<C-l>"] = { "snippet_forward", "fallback" },
                ["<C-h>"] = { "snippet_backward", "fallback" },
            },

            completion = {
                menu = { border = "rounded" },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 200,
                    window = { border = "rounded" },
                },
            },

            sources = {
                default = { "lazydev", "lsp", "path", "snippets" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
}
