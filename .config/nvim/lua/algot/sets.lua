vim.opt.nu = true;

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10

vim.opt.updatetime = 50
vim.opt.colorcolumn = '80'

vim.wo.relativenumber = true;

vim.o.autoread = true
