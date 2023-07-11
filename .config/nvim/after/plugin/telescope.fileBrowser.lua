require("telescope").setup {
    extensions = {
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = true,
        }
    }
}

require("telescope").load_extension "file_browser"

vim.keymap.set('n', '<leader>n', ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set('n', '<leader>m', ":Telescope file_browser")
