local dap = require('dap')

vim.keymap.set('n', '<leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<leader>do', function() dap.step_over() end)
vim.keymap.set('n', '<leader>di', function() dap.step_into() end)
vim.keymap.set('n', '<leader>du', function() dap.step_out() end)

vim.keymap.set('n', '<leader>b', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() dap.set_breakpoint() end)
vim.keymap.set('n', '<leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point msg: ')) end)

vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end)

local ui = require('dap.ui.widgets')

vim.keymap.set({'n','v'}, '<leader>dh', function() ui.hover() end)
vim.keymap.set({'n','v'}, '<leader>dp', function() ui.preview() end)

dap.adapters.coreclr = {
    type='executable',
    command = '/home/algoth/.local/share/nvim/mason/bin/netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = {
    {
        type = 'coreclr',
        name = 'launch - netcoredbg',
        request = 'launch',
        program = function()
            local project = vim.fn.input('Choose project: ', vim.fn.getcwd(), 'dir')
            return vim.fn.input('Dll to run: ', project .. 'bin/Debug/net', 'file')
        end,
    },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})

