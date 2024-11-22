return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        local nvimtree = require("nvim-tree")

        -- Recommended settings
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
            view = {
                width = 35,
                relativenumber = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
                icons = {
                    glyphs = {
                        folder = {
                            arrow_closed = "",
                            arrow_open = "",
                        },
                    },
                },
            },
            actions = {
                open_file = {
                    window_picker = {
                        enable = false,
                    },
                },
            },
            filters = {
                custom = { ".DS_Store" },
            },
            git = {
                ignore = false,
            },
            ui = {
                confirm = {
                    remove = true,
                    trash = false,
                },
            },
            on_attach = function(bufnr)
                local api = require("nvim-tree.api")
                local opts = function(desc)
                    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
                end

                -- mark operation
                local mark_move_j = function()
                    api.marks.toggle()
                    vim.cmd("norm j")
                end
                local mark_move_k = function()
                    api.marks.toggle()
                    vim.cmd("norm k")
                end

                -- marked files operation
                local mark_trash = function()
                    local marks = api.marks.list()
                    if #marks == 0 then
                        table.insert(marks, api.tree.get_node_under_cursor())
                    end
                    vim.ui.input({ prompt = string.format("Trash %s files? [y/n] ", #marks) }, function(input)
                        if input == "y" then
                            for _, node in ipairs(marks) do
                                api.fs.trash(node)
                            end
                            api.marks.clear()
                            api.tree.reload()
                        end
                    end)
                end
                local mark_remove = function()
                    local marks = api.marks.list()
                    if #marks == 0 then
                        table.insert(marks, api.tree.get_node_under_cursor())
                    end
                    vim.ui.input({ prompt = string.format("Remove/Delete %s files? [y/n] ", #marks) }, function(input)
                        if input == "y" then
                            for _, node in ipairs(marks) do
                                api.fs.remove(node)
                            end
                            api.marks.clear()
                            api.tree.reload()
                        end
                    end)
                end

                local mark_copy = function()
                    local marks = api.marks.list()
                    if #marks == 0 then
                        table.insert(marks, api.tree.get_node_under_cursor())
                    end
                    for _, node in pairs(marks) do
                        api.fs.copy.node(node)
                    end
                    api.marks.clear()
                    api.tree.reload()
                end
                local mark_cut = function()
                    local marks = api.marks.list()
                    if #marks == 0 then
                        table.insert(marks, api.tree.get_node_under_cursor())
                    end
                    for _, node in pairs(marks) do
                        api.fs.cut(node)
                    end
                    api.marks.clear()
                    api.tree.reload()
                end

                vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
                vim.keymap.set("n", "m", mark_move_j, opts("Toggle Bookmark Down"))
                vim.keymap.set("n", "M", mark_move_k, opts("Toggle Bookmark Up"))

                vim.keymap.set("n", "x", mark_cut, opts("Cut File(s)"))
                vim.keymap.set("n", "d", mark_trash, opts("Trash File(s)"))
                vim.keymap.set("n", "D", mark_remove, opts("Remove File(s)"))
                vim.keymap.set("n", "y", mark_copy, opts("Copy File(s)"))

                vim.keymap.set("n", "mv", api.marks.bulk.move, opts("Move Bookmarked"))
                vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open file"))
            end,
        })

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current buffer" })
        keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
        keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    end
}
