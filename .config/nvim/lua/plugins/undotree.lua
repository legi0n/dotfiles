return  {
    "mbbill/undotree",
    keys = {
        { "<leader>tu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
    init = function()
        vim.g.undotree_SetFocusWhenToggle = 1
    end
}
