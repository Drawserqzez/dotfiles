local dap = require('dap')

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local custom_picker = function(extension)
    local opts = {}
    return pickers.new(opts, {
        prompt_title='Select ' .. extension,
        finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "f", "-e", extension }, opts),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(buf_no)
            actions.select_default:replace(function()
                actions.close(buf_no)
                return action_state.get_selected_entry()[1]
            end)
            return true
        end,
    })
    :find()
end

local print_selected_entry = function(buf_no)
    local selected_entry = action_state.get_selected_entry()
    vim.pretty_print(selected_entry)
    actions.close(buf_no)
end

local dotnet_build = function()
    local default_path = vim.fn.getcwd() .. '/'

    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end

    local path = vim.fn.input('Path to your proj file: ', default_path, 'file')
    -- local path = custom_picker('csproj')
    -- local path = require('telescope.builtin').find_files({
    --     hidden = true,
    --     no_ignore = true,
    --     search_file='.csproj',
    --     prompt_title = 'find csproj',
    --     attach_mappings = function(_, map)
    --         map('n', '<cr>', print_selected_entry)
    --         map('i', '<cr>', print_selected_entry)
    --         return true
    --     end,
    -- })

    vim.g['dotnet_last_proj_path'] = path

    local cmd = { 'dotnet', 'build', '-c', 'Debug', path, '>', '/dev/null' }

    -- todo: improve use of notify
    require('notify')('Building...', 'info')

    local on_build_finish = function(res)
        if res.code == 0 then
            require('notify')('Build finished ✔️ ', 'info')
        else
            require('notify')('\nBuild failed ❌ (code: ' .. res.code .. '), Msg: ' .. res.stderr, 'error')
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

