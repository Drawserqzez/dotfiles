local gitsigns = require('gitsigns')

gitsigns.setup {
    current_line_blame = true,
    current_line_blame_formatter = " <author>, <author_time:%R> - '<abbrev_sha>' <summary> ",
    on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gb', gitsigns.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>gB', function() gitsigns.blame_line{full=true} end)
        vim.keymap.set('n', '<leader>gd', gitsigns.diffthis)
        vim.keymap.set('n', '<leader>gD', function() gitsigns.diffthis('~') end)
    end,
}
