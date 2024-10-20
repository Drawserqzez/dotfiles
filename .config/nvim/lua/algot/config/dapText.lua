require('nvim-dap-virtual-text').setup({
    enabled = true,
    highlight_changed_variables = true,
    show_stop_reason = true,
    commented = false,
    virt_text_pos = vim.fn.has('nvim-0.10') == 1 and 'inline' or 'eol',
})
