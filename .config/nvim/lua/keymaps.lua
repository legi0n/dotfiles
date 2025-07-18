-- [[ Global Keymaps ]]
-- See `:help vim.keymap.set()` for more details.

local function create_cmd(cmd)
    return function()
        vim.cmd(cmd)
    end
end

-- Plugin Management (Lazy.nvim)
vim.keymap.set("n", "<leader>ph", vim.cmd.Lazy, { desc = "[P]lugins [H]ome" })
vim.keymap.set("n", "<leader>pi", create_cmd "Lazy install", { desc = "[P]lugins [I]nstall" })
vim.keymap.set("n", "<leader>pu", create_cmd "Lazy update", { desc = "[P]lugins [U]pdate" })
vim.keymap.set("n", "<leader>ps", create_cmd "Lazy sync", { desc = "[P]lugins [S]ync" })
vim.keymap.set("n", "<leader>pc", create_cmd "Lazy clean", { desc = "[P]lugins [C]lean" })

-- Mason Management
vim.keymap.set("n", "<leader>pmh", vim.cmd.Mason, { desc = "[P]lugins [M]ason [H]ome" })
vim.keymap.set("n", "<leader>pmu", create_cmd "MasonUpdate", { desc = "[P]lugins [M]ason [U]pdate" })

-- Buffer Navigation
vim.keymap.set("n", "<leader>be", vim.cmd.Ex, { desc = "[B]uffer [E]xplorer (Netrw)" })
vim.keymap.set("n", "<leader>bn", vim.cmd.bnext, { desc = "[B]uffer [N]ext" })
vim.keymap.set("n", "<leader>bp", vim.cmd.bprevious, { desc = "[B]uffer [P]revious" })
vim.keymap.set("n", "<leader>bd", vim.cmd.bdelete, { desc = "[B]uffer [D]elete" })

-- Window Navigation
-- Use CTRL + hjkl to move between split windows
-- See `:help wincmd` for available window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Terminal Mode
-- Easier way to exit terminal mode (alternative to <C-\><C-n>)
-- NOTE: May not work in all terminal emulators or tmux setups.
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Search and Highlighting
vim.keymap.set("n", "<Esc>", create_cmd "set nohlsearch", { desc = "Clear search highlights" })

-- Disable Arrow Keys
-- Discourage arrow key movement in normal mode
vim.keymap.set("n", "<left>", "<nop>")
vim.keymap.set("n", "<right>", "<nop>")
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
