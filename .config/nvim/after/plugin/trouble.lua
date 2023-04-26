local trouble = require("trouble")

trouble.setup {}

vim.keymap.set('n', '<leader>tt', vim.cmd.TroubleToggle)

