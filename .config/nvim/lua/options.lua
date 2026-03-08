-- See :help vim.opt and :help option-list for more details.

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line Display
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true -- Highlight the current line

-- Show Whitespace
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Editing and Formatting
vim.opt.breakindent = true -- Enable break indent
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.softtabstop = 4 -- Number of spaces per tab while editing
vim.opt.shiftwidth = 4 -- Number of spaces for indentation
vim.opt.expandtab = true -- Use spaces instead of tabs

-- Searching
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true -- ...unless uppercase is used in the query
vim.opt.inccommand = "split" -- Show live preview of substitutions

-- Split Windows
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below

-- Performance Tweaks
vim.opt.updatetime = 250 -- Reduce time before swapfile writes
vim.opt.timeoutlen = 300 -- Reduce time for mapped sequence wait time

-- Undo and History
vim.opt.undofile = true -- Enable persistent undo

-- Diagnostics (inline errors/warnings)
vim.diagnostic.config({
    virtual_text = true, -- Show inline text
    signs = true, -- Icons in the gutter
    underline = true, -- Underline problematic code
    update_in_insert = false, -- Don't update diagnostics while typing
    severity_sort = true, -- Sort errors by severity
})
