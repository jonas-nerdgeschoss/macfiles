return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            javascript = { "prettier" },
            json = { "prettier" },
            markdown = { "deno_fmt" },
            scss = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {},
        formatters = {
            deno_fmt = {
                append_args = { "--line-width", "999999" }, -- Don't add line wraps in order for markdown to look good on GitHub. Use `set wrap` in the editor instead.
            },
        },
    },
}
