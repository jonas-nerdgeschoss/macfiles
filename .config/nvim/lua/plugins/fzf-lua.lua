return {
    "ibhagwan/fzf-lua",
    dependencies = {
        "echasnovski/mini.icons",
    },
    keys = {
        { "<leader>ff",  function() require("fzf-lua").files() end },
        { "<leader>fg",  function() require("fzf-lua").live_grep() end },
        { "<leader>fr",  function() require("fzf-lua").oldfiles({ cwd_only = true }) end },
        { "<leader>fcf", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end },
        { "<leader>fcg", function() require("fzf-lua").live_grep({ cwd = vim.fn.stdpath("config") }) end },
        { "<leader>fcr", function() require("fzf-lua").oldfiles({ cwd = vim.fn.stdpath("config"), cwd_only = true }) end },
        { "<leader>fh",  function() require("fzf-lua").helptags() end },
        { "z=",          function() require("fzf-lua").spell_suggest() end },
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
