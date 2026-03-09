return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "master",
    main = "nvim-treesitter.configs",
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

        auto_install = true,

        highlight = {
            enable = true,
        },

        indent = {
            enable = true,
        },
    },
}
