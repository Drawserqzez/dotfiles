require('rose-pine').setup({
    variant = 'moon',
    dark_variant = 'moon',
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        migrations = true,
    },

    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },

    highlight_group = {
        TelescopeBorder = { fg = "highlight_high", bg = "none" },
		TelescopeNormal = { bg = "none" },
		TelescopePromptNormal = { bg = "base" },
		TelescopeResultsNormal = { fg = "subtle", bg = "none" },
		TelescopeSelection = { fg = "text", bg = "base" },
		TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
		NotifyBackground = { bg = "none" },
    },
})

vim.cmd('colorscheme rose-pine')

