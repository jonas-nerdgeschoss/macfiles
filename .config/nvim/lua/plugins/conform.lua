return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            scss = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {},
    },
}
