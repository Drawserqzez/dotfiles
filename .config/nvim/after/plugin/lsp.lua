local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer'
})

-- Some of the default keymaps conflict with mine (=
lsp.set_preferences({
    set_lsp_keymaps = false
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
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
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gh', function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', 'grf', function() vim.lsp.buf.references() end, opts)
  vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<leader>h', function() vim.diagnostic.open_float() end, opts)
end)

-- enables lsp support for nvim config
lsp.nvim_workspace()

lsp.setup()
