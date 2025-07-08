return {
    -- Ensure these languages are installed for Treesitter
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
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
    },

    -- Automatically install missing parsers
    auto_install = true,

    -- Highlighting configurations
    highlight = {
        enable = true, -- Enable Treesitter-based syntax highlighting
        -- Some languages (like Ruby) use Vim's regex-based highlighting system for indent rules.
        -- If you are experiencing weird indenting issues, you can add the language to the list of
        -- additional_vim_regex_highlighting to disable Treesitter for indentation.
        -- additional_vim_regex_highlighting = { },
    },

    -- Indentation configurations
    indent = {
        enable = true, -- Enable Treesitter-based indentation
        -- disable = { },
    },
}
