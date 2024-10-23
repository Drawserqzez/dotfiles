local neotest = require('neotest')
local dotnet = require('neotest-dotnet')
local dap = require('dap')

local run_with_dap = function()
    neotest.summary.open()
    neotest.run.run({ strategy="dap" })
    dap.repl.open()
end

local rerun_with_dap = function()
    neotest.summary.open()
    neotest.run.run_last({ strategy="dap" })
    dap.repl.open()
end

local open_summary = function()
    neotest.summary.open()
end

neotest.setup({
    adapters = {
        dotnet({
            dap = {
                discovery_root="project",
                adapter_name = "coreclr"
            }
        })
    },
    discovery = {
        enabled = true,
        concurrent = 0,
    },
    status = {
        enabled = true,
        signs = true,
        virtual_text = true,
    },
})

vim.keymap.set('n', '<leader>trr', function() open_summary() neotest.run.run() end)
vim.keymap.set('n', '<leader>trf', function() open_summary() neotest.run.run(vim.fn.expand('%')) end)
vim.keymap.set('n', '<leader>tra', function() open_summary() neotest.run.run({suite=true}) end)
vim.keymap.set('n', '<leader>trd', function() run_with_dap() end)
vim.keymap.set('n', '<leader>trw', function() rerun_with_dap() end)

vim.keymap.set('n', '<leader>trs', function() open_summary() neotest.run.stop() end)

vim.keymap.set('n', '<leader>tos', function() neotest.summary.toggle() end)

