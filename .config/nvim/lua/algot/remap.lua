vim.g.mapleader = " "
local map = vim.keymap.set

map('i', 'jkl', '<Esc>', { noremap = true })

map('n', 'ö', '^', { noremap = true })
map('v', 'ö', '^', { noremap = true })
map('n', 'ä', '$', { noremap = true })
map('v', 'ä', '$', { noremap = true })

map('n', '<C-d>', '<C-d>zz', { noremap = true })
map('n', '<C-u>', '<C-u>zz', { noremap = true })

map('n', '<leader>s', vim.cmd.sp)
map('n', '<leader>v', vim.cmd.vsp)

map('n', 'gs', '<C-w>', { noremap = true })

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

map('n', '<leader>l', ':noh<CR>', { silent=true })

map('n', '<leader>cwd', ':cd %:h <CR>')
map('n', '<leader>cfr', ':source ~/.config/nvim/init.lua <CR>')

map('n', '<leader>tn', ':tabnew<CR>', { silent = true })
