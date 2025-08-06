require("referencer").setup({
    enable = false,                      -- enable after LSP attach
    format = "  %d reference(s)",       -- format string for reference count
    show_no_reference = true,            -- show if refs count = 0
    kinds = { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 22, 23,  }, -- LSP SymbolKinds to show references for
    hl_group = "Comment",                -- default highlight group
    virt_text_pos = "eol",               -- virtual text position (eol | overlay | right_align)
    use_virt_lines = true,
    pattern = nil,                       -- pattern for LspAttach autocmd to auto-enable
    lsp_servers = { 'omnisharp' }       -- list of servers for which this plugin will be active. nil or {} is ALL LSP clients
})
