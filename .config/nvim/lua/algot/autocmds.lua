-- partly copied from LazyVim setup

local function augroup(name)
    return vim.api.nvim_create_augroup('customvim_' .. name, { clear = true })
end

-- check if we need to reload file
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
    group = augroup('checktime'),
    callback = function()
        if vim.o.buftype ~= 'nofile' then
            vim.cmd('checktime')
        end
    end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = augroup('highlight_yank'),
    callback = function()
        vim.highlight.on_yank()
    end,
})

--vim.api.nvim_create_autocmd('VimResized', {
    --group = augroup('resize_splits'),
    --callback = function()
        --local current_tab = vim.fn.tabpagenr
        --vim.cmd('tabdo wincmd =')
        --vim.cmd('tabnext ' .. current_tab)
    --end,
--})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup('close_with_q'),
    pattern = {
        'PlenaryTestPopup',
        'help',
        'lspinfo',
        'notify',
        'qf',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'neotest-output',
        'checkhealth',
        'neotest-summary',
        'neotest-output-panel',
        'dap-preview',
        'dap-float',
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false,
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    group = augroup('wrap_spell'),
    pattern = { 'gitcommit', 'markdown' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = augroup('inlay_hints'),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, {})
        end
    end,
})

