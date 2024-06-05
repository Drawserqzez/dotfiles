require('rose-pine').setup({
    variant = 'main',
    dark_variant = 'main',
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        migrations = true,
    },

    
})

vim.cmd('colorscheme rose-pine')

