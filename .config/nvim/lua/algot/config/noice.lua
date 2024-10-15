require('noice').setup({
    lsp = {
        override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
        }
    },
    presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
    },
    views = {
        notify = {
            merge = true,
            replace = true,
        }
    },
    routes = {
        {
            filter = {
                event = 'msg_show',
                kind = "",
                find = "written",
            },
            opts = { skip = true },
        },
        {
            view = "notify",
            filter = { event = "msg_showmode" },
        },
    },
})

require('notify').setup({
    background_colour = "#000000",
    render="compact"
})
