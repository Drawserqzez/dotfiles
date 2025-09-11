require('mason').setup({})

-- vim.lsp.config('ts_ls', {
--     init_options = {
--         plugins = {
--             {
--                 name = '@vue/typescript-plugin',
--                 location = vim.fn.expand(
--                     '$MASON/packages/vue-language-server/node_modules/@vue/language-server/'),
--                 languages = { 'vue' },
--                 enableForWorkspaceTypeScriptVersions = true,
--                 configNamespace = 'typescript'
--             }
--         },
--     },
--     filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
-- })

vim.lsp.config('vtsls', {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = '@vue/typescript-plugin',
                        location = vim.fn.expand(
                            '$MASON/packages/vue-language-server/node_modules/@vue/language-server/'),
                        languages = { 'vue' },
                        enableForWorkspaceTypeScriptVersions = true,
                        configNamespace = 'typescript'
                    }
                },
            },
        },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
})

vim.lsp.config('emmet_ls', {
    filetypes = {
        'html',
        'typescriptreact',
        'javascriptreact',
        'css',
        'sass',
        'scss',
        'less',
        'vue',
    },
})

vim.lsp.config('tailwindcss', {
    filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
    settings = {
        tailwindCSS = {
            experimental = {
                classRegex = {
                    "tw`([^`]*)",
                    "tw=\"([^\"]*)",
                    "tw={\"([^\"}]*)",
                    "tw\\.\\w+`([^`]*)",
                    "tw\\(.*?\\)`([^`]*)",
                },
            },
        },
    },
})

vim.lsp.log.set_level(vim.log.levels.DEBUG)


require('mason-lspconfig').setup({
    ensure_installed = { 'emmet_ls', 'vue_ls', 'vtsls', 'omnisharp', 'lua_ls', 'tailwindcss' },
    automatic_enable = true,
})

local cmp = require('cmp')
local types = require('cmp.types')

local function deprioritise_snippet(entry1, entry2)
    if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then return false end
    if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then return true end
end

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sorting = {
        priority_weight = 2,
        comparators = {
            deprioritise_snippet,
            -- the rest of the comparators are pretty much the defaults
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.scopes,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('LspStuff', {}),
    callback = function(e)
        local opts = { buffer = e.buf, remap = false }
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
    end
})


