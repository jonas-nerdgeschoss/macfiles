return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-context",
            opts = {
                multiline_threshold = 5,
            },
        },
    },
    config = function()
        local parsers = {
            "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
            "ruby", "embedded_template", "html", "css", "javascript", "typescript", "dockerfile", "yaml",
            "graphql", "slim",
        }
        local filetypes = vim.iter(parsers)
            :map(function(parser)
                return vim.treesitter.language.get_filetypes(parser)
            end)
            :flatten()
            :totable()

        require("nvim-treesitter").install(parsers)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetypes,
            callback = function(args)
                vim.treesitter.start()
                vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
