return {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
        local bg = "#1e1d2c"
        local bg_dark = "#1e1d2c"
        local bg_highlight = "#074a64"
        local bg_search = "#0a64ac"
        local bg_visual = "#275378"
        local fg = "#cbe0f0"
        local fg_dark = "#b4d0e9"
        local fg_gutter = "#627e97"
        local border = "#547998"
        local comment = "#c2c2c2"


        require("tokyonight").setup({
            style = "night",
            on_colors = function(colors)
                colors.bg = bg
                colors.bg_dark = bg_dark
                colors.bg_float = bg_dark
                colors.bg_highlight = bg_highlight
                colors.bg_popup = bg_dark
                colors.bg_search = bg_search
                colors.bg_sidebar = bg_dark
                colors.bg_statusline = bg_dark
                colors.bg_visual = bg_visual
                colors.border = border
                colors.fg = fg
                colors.fg_dark = fg_dark
                colors.fg_float = fg
                colors.fg_gutter = fg_gutter
                colors.fg_sidebar = fg_dark
                colors.comment = comment
            end
        })

        vim.cmd("colorscheme tokyonight")
        vim.cmd("highlight ColorColumn ctermbg=lightgrey guibg=#2a2a40")
    end
}
