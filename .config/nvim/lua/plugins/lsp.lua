return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        "ibhagwan/fzf-lua",
    },
    opts = {
        ensure_installed = {
            "docker_compose_language_service",
            "dockerls",
            "eslint",
            "lua_ls",
            "ruby_lsp",
            "ts_ls",
        },
    },
    init = function()
        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    format = {
                        defaultConfig = {
                            call_arg_parentheses = "keep",
                            quote_style = "double",
                            trailing_table_separator = "smart",
                        },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        })

        vim.lsp.config("herb_ls", {
            filetypes = { "html", "eruby" },
        })
        vim.lsp.enable("herb_ls")

        vim.lsp.config("ruby_lsp", {
            cmd = { os.getenv("HOME") .. "/.local/share/mise/shims/ruby-lsp" },
            init_options = {
                formatter = "rubocop",
                linters = {
                    "rubocop",
                },
            },
        })

        vim.lsp.config("tailwindcss", {
            settings = {
                tailwindCSS = {
                    experimental = {
                        -- For `class:` attributes in .erb files
                        classRegex = {
                            [=["([^"]*)"]=],
                            [=['([^']*)']=],
                        },
                    },
                },
            },
        })

        -- ---@param command lsp.Command
        -- local function handler(command, ctx)
        --     vim.notify(command.command)
        --     for key, value in ipairs(command.arguments) do
        --         vim.notify(tostring(value))
        --     end
        --     -- require("jdtls.async").run(function()
        --     --     local _, result = request(ctx.bufnr, "java/checkToStringStatus", ctx.params)
        --     --     local fields = ui.pick_many(result.fields, "Include item in toString?", function(x)
        --     --         return string.format("%s: %s", x.name, x.type)
        --     --     end)
        --     --     local _, edit = request(ctx.bufnr, "java/generateToString", { context = ctx.params, fields = fields })
        --     --     vim.lsp.util.apply_workspace_edit(edit, offset_encoding)
        --     -- end)
        -- end

        -- vim.lsp.commands["rubyLsp.runTestInTerminal"] = handler

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("my.lsp", {}),
            callback = function(args)
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

                if client:supports_method("textDocument/definition") then
                    vim.keymap.set("n", "gd", function()
                        vim.lsp.buf.definition({ bufnr = args.buf, id = client.id })
                    end)
                end
                if client:supports_method("textDocument/formatting") then
                    vim.keymap.set("n", "<leader>f", function()
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                    end)
                end
                if client:supports_method("textDocument/codeAction") then
                    vim.keymap.set("n", "gra", require("fzf-lua").lsp_code_actions)
                end
                if client:supports_method("textDocument/references") then
                    vim.keymap.set("n", "grr", require("fzf-lua").lsp_references)
                end
                if client:supports_method("textDocument/implementation") then
                    vim.keymap.set("n", "gri", require("fzf-lua").lsp_implementations)
                end
                if client:supports_method("textDocument/documentSymbol") then
                    vim.keymap.set("n", "gO", require("fzf-lua").lsp_document_symbols)
                end
                if client:supports_method("textDocument/inlayHint") then
                    vim.keymap.set("n", "<leader>ih",
                        function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end)
                end
            end,
        })
    end,
}
