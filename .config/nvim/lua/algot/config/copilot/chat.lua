local chat = require('CopilotChat')

chat.setup({
    window = {
        layout = 'float',
        relative = 'cursor',
        width = 0.4,
        height = 0.8,
        row = 24,
    },
})

vim.keymap.set('n', '<leader>ch', function() chat.open() end)
vim.keymap.set('v', '<leader>ch', function() chat.open() end)

