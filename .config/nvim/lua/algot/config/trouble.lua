local trouble = require('trouble')

trouble.setup {
    focus = true,
    indent_guides = true,
    auto_close = true,
}

vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle<CR>')

