return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        "stevearc/aerial.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                    },
                },
            },
            extensions = {
                aerial = {
                    col1_width = 4,
                    col2_width = 30,
                    format_symbol = function(symbol_path, filetype)
                        if filetype == "json" or filetype == "yaml" then
                            return table.concat(symbol_path, ".")
                        else
                            return symbol_path[#symbol_path]
                        end
                    end,
                    show_columns = "both",
                }
            }
        })

        telescope.load_extension("fzf")
        telescope.load_extension("aerial")
        telescope.load_extension("projects")

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy-find files in cwd" })
        keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy-find recent files" })
        keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
        keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
        keymap.set("n", "<leader>fp", "<cmd>Telescope git_files<CR>",
            { desc = "Fuzzy-find project files tracked by git" })
        keymap.set("n", "<leader>fu", "<cmd>Telescope git_status<CR>", { desc = "Fuzzy-find changed project files" })
        keymap.set("n", "<leader>ft", "<cmd>Telescope aerial<CR>", { desc = "Show ctags" })
    end,
}
