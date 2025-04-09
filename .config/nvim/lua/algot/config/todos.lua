local todo = require('todo-comments')

todo.setup {
    keywords = {
        TODO = {
            icon = " ",
            color = "info",
            alt = { "todo", "ToDo", "Todo" }
        },
        FIX = {
            icon = " ",
            color = "error",
            alt = { "fixme", "FixMe", "Fixme", "bug", "BUG", "Bug" }
        },
        HACK = {
            alt = { "hack", "Hack" }
        },
        -- todo: more keywords?
    },
    merge_keywords = true
}

local config = require('todo-comments.config')

-- vim.keymap.set('n', '<leader>td', vim.cmd.TodoTrouble)
vim.keymap.set('n', '<leader>td', vim.cmd.TodoTelescope)

