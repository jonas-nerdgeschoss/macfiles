-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("my.highlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Set slim filetype on *.slim files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.slim" },
    command = "set ft=slim",
})
