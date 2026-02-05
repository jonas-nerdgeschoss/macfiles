-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("my.highlight", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Set slim filetype on *.slim files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.slim" },
    callback = function()
        vim.cmd("set ft=slim")
    end,
})
