return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            css = { "prettier" },
            -- eruby = { "tailwindcss_class_sorter_erb", lsp_format = "last" },
            javascript = { "prettier" },
            json = { "prettier" },
            markdown = { "mdformat", "prettier" },
            scss = { "prettier" },
            templ = { "prettier", lsp_format = "last" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
        format_on_save = {},
        formatters = {
            mdformat = {
                append_args = { "--wrap", "80" },
            },
            tailwindcss_class_sorter_erb = {
                command = "node_modules/.bin/tailwindcss-class-sorter-erb",
                condition = function(_, _)
                    local filename = vim.fn.expand("%:t")
                    local ending = ".html.erb"
                    return string.sub(filename, - #ending) == ending
                end,
            },
        },
    },
}
