local kanagawa = require('kanagawa')


kanagawa.setup({
    transparent = true,
    dimInactive = false,
    terminalColours = true,
    colors = {
        theme = {
            all = {
                ui = { 
                    bg_gutter = "none"
                }
            }
        }
    }
})

vim.cmd('colorscheme kanagawa-wave')
