return {
    {
        "nvim-mini/mini.move",
        version = "*",
        opts = {},
    },
    {
        "nvim-mini/mini.statusline",
        version = "*",
        opts = {},
        config = function(_, opts)
            local statusline = require("mini.statusline")
            statusline.setup(opts)

            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
}
