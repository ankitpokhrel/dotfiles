return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            "<leader>==",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua", lsp_format = "fallback" },
            go = { "gofmt", lsp_format = "fallback" },
            zig = { "zigfmt", lsp_format = "fallback" },
            json = { "jq" },
            yaml = { "yamlfmt" },
        },
        default_format_opts = {
            lsp_format = "last",
        },
        format_on_save = { timeout_ms = 500 },
        formatters = {
            shfmt = {
                prepend_args = { "-i", "2" },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
