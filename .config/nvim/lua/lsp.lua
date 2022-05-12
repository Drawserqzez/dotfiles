local pid = vim.fn.getpid()
nvim_lsp.omnisharp.setup(extended_setup({
    cmd = { vim.g.config_omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    handlers = {
        ['textDocument/definition'] = require('omnisharp-extended').handler
    }
}))
