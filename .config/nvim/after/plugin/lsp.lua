local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'rust_analyzer',
})

-- Some of the default keymaps conflict with mine (=
lsp.set_preferences({
    set_lsp_keymaps = false
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local map = vim.keymap.set

    map('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    map('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    map('n', 'gi', function() vim.lsp.buf.implementation() end, opts)
    map('n', 'gh', function() vim.lsp.buf.hover() end, opts)
    map('n', 'grn', function() vim.lsp.buf.rename() end, opts)
    map('n', 'grf', function() vim.lsp.buf.references() end, opts)
    map('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    map('n', '<leader>h', function() vim.diagnostic.open_float() end, opts)
end)

-- enables lsp support for nvim config
lsp.nvim_workspace()

lsp.setup()

local lspconfig = require('lspconfig');

lspconfig.emmet_ls.setup({
    filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less', 'vue' }
})
