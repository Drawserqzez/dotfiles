local pid = vim.fn.getpid()
nvim_lsp.omnisharp.setup(extended_setup({
    cmd = { vim.g.config_omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    root_dir = function(path)
        return root_pattern('*.sln')(path) or root_pattern('*.csproj')(path)
    end,
    handlers = {
        ['textDocument/definition'] = require('omnisharp-extended').handler
    }
}))
