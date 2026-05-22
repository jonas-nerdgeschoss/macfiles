vim.keymap.set("n", "<leader>ss", function()
    local rspec_command = "bundle exec rspec " .. vim.fn.expand("%:o") .. ":" .. vim.fn.getpos(".")[2]
    local shell_command = "${SHELL-bash}"
    local outer_command = "tmux split-window -h '" .. rspec_command .. "; " .. shell_command .. "'"
    vim.fn.jobstart(outer_command)
end)

vim.keymap.set("n", "<leader>sf", function()
    local rspec_command = "bundle exec rspec " .. vim.fn.expand("%:o")
    local shell_command = "${SHELL-bash}"
    local outer_command = "tmux split-window -h '" .. rspec_command .. "; " .. shell_command .. "'"
    vim.fn.jobstart(outer_command)
end)
