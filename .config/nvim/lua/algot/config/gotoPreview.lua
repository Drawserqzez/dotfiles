local preview = require('goto-preview')

preview.setup{}

vim.keymap.set('n', '<leader>d', preview.goto_preview_definition)
vim.keymap.set('n', '<leader>D', preview.goto_preview_type_definition)
vim.keymap.set('n', '<leader>i', preview.goto_preview_implementation)
vim.keymap.set('n', '<leader>r', preview.goto_preview_references)
vim.keymap.set('n', '<leader>q', preview.close_all_win)

