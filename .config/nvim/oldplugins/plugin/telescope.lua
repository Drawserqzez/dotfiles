local telescope = require('telescope')
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>fr', builtin.live_grep, {})

telescope.setup {
    extensions = {
        file_browser = {
            hijack_netrw = true,
            respect_gitignore = true,
        },
        ['ui_select'] = {
            require('telescope.themes').get_dropdown {
                layout_strategy = 'vertical',
                layout_config = {
                    prompt_position = 'bottom',
                    vertical = {
                        width = 0.8,
                    }
                }
            }
        }
    }
}

telescope.load_extension("file_browser")
telescope.load_extension('ui-select')

vim.keymap.set('n', '<leader>n', ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set('n', '<leader>m', ":Telescope file_browser")

