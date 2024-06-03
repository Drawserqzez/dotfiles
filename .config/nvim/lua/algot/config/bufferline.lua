require('bufferline').setup {
    options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match('error') and ' ' or ' '
            return ' ' .. icon .. count
        end,
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Tree',
                text_align = 'center',
                separator = true,
            }
        },
        color_icons = true,
        separator_style = 'slope',
        sort_by = 'directory'
    }
}

