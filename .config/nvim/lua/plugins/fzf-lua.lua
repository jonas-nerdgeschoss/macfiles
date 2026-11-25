return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "echasnovski/mini.icons",
    },
    keys = {
        { "<leader>ff", function() require("fzf-lua").files() end },
        { "<leader>fg", function() require("fzf-lua").live_grep() end },
        { "<leader>fr", function() require("fzf-lua").oldfiles({ cwd_only = true }) end },
        { "<leader>fd", function() require("fzf-lua").git_diff() end },
        { "<leader>fh", function() require("fzf-lua").helptags() end },
        { "<leader>fj", function()
            require("fzf-lua").fzf_exec("bundle list --name-only", {
                actions = {
                    ["default"] = function(selected)
                        vim.fn.system({ "bdj", selected[1] })
                    end,
                },
                preview = "cat $(bundle show {})/README.md",
            })
        end },
        { "<leader>fk", function() require("fzf-lua").live_grep({ search = vim.fn.expand("<cword>") }) end },
        { "z=",         function() require("fzf-lua").spell_suggest() end },
    },
    opts = {
        fzf_opts = {
            ["--cycle"] = true,
        },
        grep = {
            rg_opts =
            [[--hidden -g "!.git" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e]],
        },
        keymap = {
            fzf = {
                ["ctrl-q"] = "select-all+accept",
            },
        },
    },
    init = function()
        require("fzf-lua").register_ui_select()
    end,
}
