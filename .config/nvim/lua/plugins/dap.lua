return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
        { "<leader>b", function() require("dap").toggle_breakpoint() end },
        { "<leader>d", function() require("dapui").toggle() end },
        { "<F1>",      function() require("dap").continue() end },
        { "<F2>",      function() require("dap").step_over() end },
        { "<F3>",      function() require("dap").step_into() end },
        { "<F4>",      function() require("dap").step_out() end },
        { "<F5>",      function() require("dap").step_back() end },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()
        require("nvim-dap-virtual-text").setup({
            clear_on_continue = true,
        })

        dap.adapters.ruby_rails = {
            type = "pipe",
            pipe = "/tmp/rdbg.sock",
        }

        dap.adapters.ruby_rspec = function(callback, config)
            local location = config.file
            if config.line then
                location = location .. ":" .. config.line
            end
            callback({
                type = "server",
                host = "127.0.0.1",
                port = "${port}",
                executable = {
                    command = "bundle",
                    args = {
                        "exec", "rdbg", "--nonstop", "--open", "--port", "${port}",
                        "--command", "--", "bundle", "exec", "rspec", location,
                    },
                },
            })
        end

        dap.configurations.ruby = {
            {
                type = "ruby_rails",
                request = "attach",
                name = "Rails",
            },
            {
                type = "ruby_rspec",
                request = "attach",
                name = "RSpec line",
                localfs = true,
                file = function() return vim.fn.expand("%") end,
                line = function() return vim.fn.line(".") end,
            },
            {
                type = "ruby_rspec",
                request = "attach",
                name = "RSpec file",
                localfs = true,
                file = function() return vim.fn.expand("%") end,
            },
            {
                type = "ruby_rspec",
                request = "attach",
                name = "RSpec",
                localfs = true,
            },
        }

        -- Crazy hack to collapse the "Global variables" scope in dapui because it is quite noisy
        dap.listeners.before.scopes.joleconfig = function(_, _, response, _, _)
            for _, scope in ipairs(response.scopes) do
                if scope.name == "Global variables" then
                    scope.expensive = true
                    break
                end
            end
        end

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
