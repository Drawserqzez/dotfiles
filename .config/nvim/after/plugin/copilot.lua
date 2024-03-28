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
        width = 1,
        height = 0.4,
        row = 1,
    },
})

vim.keymap.set('n', 'gch', function() chat.open() end)

