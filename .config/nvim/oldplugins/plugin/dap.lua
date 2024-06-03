local dap = require('dap')

vim.keymap.set('n', 'gbp', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>k', function() dap.continue() end)
vim.keymap.set('n', '<leader>I', function() dap.step_into() end)
vim.keymap.set('n', '<leader>o', function() dap.step_over() end)
vim.keymap.set('n', '<leader>O', function() dap.step_out() end)
vim.keymap.set('n', '<leader>p', function() dap.repl.open() end)

vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)

dap.adapters.coreclr = {
    type = 'executable',
    command = '/home/algot/.local/share/nvim/mason/packages/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    }
}
