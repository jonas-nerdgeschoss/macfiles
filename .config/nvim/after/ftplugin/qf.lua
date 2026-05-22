local delete_quickfix_item = function()
    local items = vim.fn.getqflist()
    local line = vim.fn.line(".")
    table.remove(items, line)
    vim.fn.setqflist(items, "r")
    vim.api.nvim_win_set_cursor(0, { math.max(0, math.min(line, #items)), 0 })
end

vim.keymap.set("n", "dd", delete_quickfix_item, { silent = true, buffer = true })
