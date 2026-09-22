return {
    { "fei6409/log-highlight.nvim", event = "BufRead *.log", opts = {} },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "css",
                "dockerfile",
                "html",
                "java",
                "javascript",
                "json",
                "lua",
                "php",
                "python",
                "sql",
                "toml",
                "typescript",
                "vimdoc",
                "yaml",
            },
        },
    },
}
