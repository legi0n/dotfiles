return {
    { "nvim-mini/mini.move", version = "*", opts = {} },
    { "nvim-mini/mini.icons", version = "*", opts = {} },
    {
        "nvim-mini/mini.statusline",
        version = "*",
        config = function()
            local statusline = require "mini.statusline"
            statusline.setup({})
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end
    }
}
