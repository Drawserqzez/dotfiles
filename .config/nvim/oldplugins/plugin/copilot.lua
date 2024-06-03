require('copilot').setup({
    suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
            accept = "<S-Tab>",
            next = "<M-n>",
            prev = "<M-p>",
            dismiss = "<Esc>",
        }
    },
    panel = { 
        enabled = true,
        auto_refresh = true,
        keymap = { 
            open = "<M-l>"
        },
        layout = {
            position = "right",
            ratio = 0.4
        }
    }
})

require('copilot_cmp').setup()

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

