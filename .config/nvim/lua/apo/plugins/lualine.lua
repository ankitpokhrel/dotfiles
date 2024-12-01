return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
            },
            sections = {
                lualine_b = {
                  {'branch', color = {fg = '#f8fbf8'}}, -- Git branch
                },
                lualine_y = {
                  {'progress', color = {fg = '#f8fbf8'}}, -- Scroll percent
                },
            }
        })
    end
}
