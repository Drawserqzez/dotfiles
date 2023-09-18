local copilot = require('copilot')

copilot.setup({
    suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
            accept = "<Tab>",
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
            ratio = 0.3
        }
    }
})
