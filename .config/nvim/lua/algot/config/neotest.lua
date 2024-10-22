local neotest = require('neotest')
local dotnet = require('neotest-dotnet')

neotest.setup({
    adapters = {
        dotnet({
            dap = {
                discovery_root="project",
                adapter_name = "coreclr"
            }
        })
    }
})

vim.keymap.set('n', '<leader>trr', function() neotest.run.run() end)
vim.keymap.set('n', '<leader>trs', function() neotest.run.stop() end)
vim.keymap.set('n', '<leader>trd', function() neotest.run.run({ strategy="dap" }) end)
-- todo: add more keymaps to open e.x. summary or output

