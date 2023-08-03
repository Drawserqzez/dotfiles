vim.g.mapleader = " "
local map = vim.keymap.set

map('i', 'jkl', '<Esc>', { noremap = true })

map('n', 'ö', '^', { noremap = true })
map('v', 'ö', '^', { noremap = true })
map('n', 'ä', '$', { noremap = true })
map('v', 'ä', '$', { noremap = true })

map('n', 'J', '5j', { noremap = true })
map('n', 'K', '5k', { noremap = true })
map('n', 'H', '10h', { noremap = true })
map('n', 'L', '10l', { noremap = true })

map('n', '<leader>s', vim.cmd.sp)
map('n', '<leader>v', vim.cmd.vsp)

map('n', 'gs', '<C-w>', { noremap = true })
map('n', '+', '<C-w>+')
map('n', '-', '<C-w>-')

map('t', 'jkl', '<C-\\><C-n>')

-- magic vim-fu thanks to theprimeagen
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- greatest remap ever
map('x', '<leader>p', "\"_dP")

-- courtesey of asbjornHaland
map('n', '<leader>y', "\"+y")
map('v', '<leader>y', "\"+y")
map('n', '<leader>Y', "\"+Y")

map('n', 'Q', '<nop>')
map('n', '<leader>b', function()
    vim.lsp.buf.format()
end)

map('n', '<leader>l', ':noh<CR>')

map('n', '<leader>cwd', ':cd %:h <CR>')
map('n', '<leader>cfr', ':source $MYVIMRC <CR>')

