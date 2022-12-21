vim.g.mapleader = " "

vim.keymap.set('i', 'jkl', '<Esc>')

vim.keymap.set('n', 'ö', '^')
vim.keymap.set('v', 'ö', '^')
vim.keymap.set('n', 'ä', '$')
vim.keymap.set('v', 'ä', '$')

vim.keymap.set('n', 'J', '5j')
vim.keymap.set('n', 'K', '5k')
vim.keymap.set('n', 'H', '10h')
vim.keymap.set('n', 'L', '10l')

vim.keymap.set('n', '<leader>s', vim.cmd.sp)
vim.keymap.set('n', '<leader>v', vim.cmd.vsp)

vim.keymap.set('n', 'gs', '<C-w>')
vim.keymap.set('n', '+', '<C-w>+')
vim.keymap.set('n', '-', '<C-w>-')

vim.keymap.set('t', 'jkl', '<C-\\><C-n>')

-- magic vim-fu thanks to theprimeagen
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- greatest remap ever
vim.keymap.set('x', '<leader>p', "\"_dP")

-- courtesey of asbjornHaland
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<leader>b', function()
    vim.lsp.buf.format()
end)
