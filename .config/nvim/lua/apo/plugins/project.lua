return {
    "zeioth/project.nvim",
    event = "User BaseDefered",
    cmd = "ProjectRoot",
    config = function()
        local project = require("project_nvim")

        project.setup({
            patterns = {
                ".git",
                "Makefile",
                "go.mod",
                "composer.json",
            },
            exclude_dirs = {
                "~/"
            },
            show_hidden = false,
            silent_chdir = true,
            manual_mode = false,

            exclude_chdir = {
                filetype = {"", "alpha"},
                buftype = {"nofile", "terminal"},
            }
        })

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<C-p>", "<cmd>Telescope projects<CR>", { desc = "Switch projects" })
    end,
}
