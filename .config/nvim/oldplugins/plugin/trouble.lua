local trouble = require("trouble")

trouble.setup {}

vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle workspace_diagnostics<CR>')

