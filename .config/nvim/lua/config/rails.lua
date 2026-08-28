local function split_and_run(command)
    local pane_id = vim.fn.system({ "tmux", "split-window", "-h", "-P", "-F", "#{pane_id}" }):gsub("%s+$", "")

    while vim.fn.system({ "tmux", "display-message", "-p", "-t", pane_id, "#{pane_current_command}" }):gsub("%s+$", "") ~= "zsh" do
        vim.wait(10)
    end

    vim.fn.system({ "tmux", "send-keys", "-t", pane_id, command, "Enter" })
end


vim.keymap.set("n", "<leader>ss", function()
    local rspec_command = "bin/rspec " .. vim.fn.expand("%:o") .. ":" .. vim.fn.getpos(".")[2]
    split_and_run(rspec_command)
end)

vim.keymap.set("n", "<leader>sf", function()
    local rspec_command = "bin/rspec " .. vim.fn.expand("%:o")
    split_and_run(rspec_command)
end)

vim.keymap.set("n", "<leader>sd", function()
    local rspec_command = "bin/rspec --dry-run --format documentation " .. vim.fn.expand("%:o")
    split_and_run(rspec_command)
end)
