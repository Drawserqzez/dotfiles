local lsp = require('lsp-zero')

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
    map('n', 'gl', function() vim.lsp.buf.workspace_symbol() end, opts)
    map('n', 'gj', function() vim.lsp.buf.code_action() end, opts)
    map('v', 'gj', function() vim.lsp.buf.code_action() end, opts)
    map('n', '<leader>m', function() vim.lsp.buf.format() end, opts)
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = { 'emmet_ls', 'volar', 'ts_ls', 'omnisharp', 'biome' },
    handlers = {
        lsp.default_setup,
        lua_ls = function()
            local lua_opts = lsp.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
    }
})

local lspconfig = require('lspconfig')

lspconfig.emmet_ls.setup({
    filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
        'vue',
    }
})

lspconfig.volar.setup {
    filetypes = { 'vue' },
    init_options = {
        vue = {
            hybridMode = false
        }
    },
    --     -- settings = {
    --     --     typescript = {
    --     --         inlayHints = {
    --     --             enumMemberValues = {
    --     --                 enabled = true,
    --     --             },
    --     --             functionLikeReturnTypes = {
    --     --                 enabled = true,
    --     --             },
    --     --             propertyDeclarationTypes = {
    --     --                 enabled = true,
    --     --             },
    --     --             parameterTypes = {
    --     --                 enabled = true,
    --     --                 suppressWhenArgumentMatchesName = true,
    --     --             },
    --     --             variableTypes = {
    --     --                 enabled = true,
    --     --             },
    --     --         },
    --     --     },
    --     -- },
}

lspconfig.ts_ls.setup {
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
        plugins = {
            {
                name = '@vue/typescript-plugin',
                location = require('mason-registry').get_package('vue-language-server'):get_install_path()
                    .. '/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin',
                languages = { 'vue' },
            }
        }
    },
    -- settings = {
    --     typescript = {
    --         tsserver = {
    --             useSyntaxServer = false,
    --         },
    --         inlayHints = {
    --             includeInlayParameterNameHints = 'all',
    --             includeInlayParameterNameHintsWhenArgumentMatchesName = true,
    --             includeInlayFunctionParameterTypeHints = true,
    --             includeInlayVariableTypeHints = true,
    --             includeInlayVariableTypeHintsWhenTypeMatchesName = true,
    --             includeInlayPropertyDeclarationTypeHints = true,
    --             includeInlayFunctionLikeReturnTypeHints = true,
    --             includeInlayEnumMemberValueHints = true,
    --         },
    --     },
    -- },
}

-- doesn't work to only use for json :(
-- lspconfig.biome.setup({
--     cmd = { 'biome', 'lsp-proxy' },
--     filetypes = {
--         'json',
--         'jsonc',
--     },
--     single_file_support = true,
--     workspace_required = false,
-- })

local cmp = require('cmp')
local lspkind = require('lspkind')

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'copilot' },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 100,
            ellipsis_char = '...',
            symbol_map = {
                Copilot = '',
            },

            before = function(entry, vim_item)
                return vim_item
            end
        }),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
})
