local dap = require('dap')

local dotnet_build = function()
    local default_path = vim.fn.getcwd() .. '/'

    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end

    local path = vim.fn.input('Path to your proj file: ', default_path, 'file')

    vim.g['dotnet_last_proj_path'] = path

    local cmd = { 'dotnet', 'build', '-c', 'Debug', path, '>', '/dev/null' }

    require('notify')('Building...', 'info')

    local on_build_finish = function(res)
        if res.code == 0 then
            require('notify')('Build finished ✔️ ', 'info')
        else
            require('notify')('\nBuild: ❌ (code: ' .. res.code .. '), Msg: ' .. res.stderr, 'error')
        end
    end

    vim.system(cmd, {}, on_build_finish)
end

local dotnet_get_dll = function()
    local find = function()
        local project = vim.fn.input('Project path: ', vim.fn.getcwd(), 'dir')
        return vim.fn.input('Dll path: ', project .. 'bin/Debug/net', 'file');
        -- return tele({ hidden = true, no_ignore = true, search_file = '.dll' })
        -- return vim.g.dap_dotnet_tele_picker('.dll', coro);
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = find()
    else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&ye\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = find()
        end
    end

    -- coroutine.yield()
    return vim.g['dotnet_last_dll_path']
end

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
            if vim.fn.confirm('Rebuild?', '&ye\n&no', 2) == 1 then
                dotnet_build()
            end

            return dotnet_get_dll()
        end,
    },
}

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='', texthl='', linehl='', numhl=''})

