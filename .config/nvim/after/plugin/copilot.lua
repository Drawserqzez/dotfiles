require('copilot').setup({
    suggestion = {
        enabled = false,
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

