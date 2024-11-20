return {
    "stevearc/aerial.nvim",
    opts = {},
    dependenceis = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local aerial = require("aerial")
        local keymap = vim.keymap

        aerial.setup({
            on_attach = function(bufnr)
                keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Go to previous tag" })
                keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Go to next tag" })
            end,
        })

        keymap.set("n", "<leader>tt", "<cmd>AerialToggle!<CR>")
    end
}
