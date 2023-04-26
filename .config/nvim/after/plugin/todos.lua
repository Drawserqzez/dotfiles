local todo = require('todo-comments')
todo.setup{
    keywords = {
        TODO = {
            alt = { "todo" }
        }
    }
}

local config = require('todo-comments.config')

vim.keymap.set('n', '<leader>td', vim.cmd.TodoTrouble)
vim.keymap.set('n', '<leader>ts', vim.cmd.TodoTelescope)

