local trouble = require('trouble')

trouble.setup {
    focus = false,
    indent_guides = true,
    auto_close = true,
}

vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<CR>')

