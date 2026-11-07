return {
    'everviolet/nvim', 
    name = 'evergarden',
    -- priority = 1000, -- Colorscheme plugin is loaded first before any other plugins

    config = function() 
        require 'evergarden'.setup({
            theme = {
                variant = 'summer', -- 'winter'|'fall'|'spring'|'summer'
                accent = 'green',
            },
            editor = {
                transparent_background = false,
                override_terminal = true,
                sign = { color = 'none' },
                float = {
                    color = 'mantle',
                    solid_border = false,
                },
                completion = {
                    color = 'surface0',
                },
            },
            style = {
                tabline = { 'reverse' },
                search = { 'italic', 'reverse' },
                incsearch = { 'italic', 'reverse' },
                types = { 'italic' },
                keyword = { 'italic' },
                comment = { 'italic' },
            },
            overrides = {},
            color_overrides = {},
        })

        -- vim.o.background = "light"
        -- vim.cmd("colorscheme evergarden")
    end,
}
