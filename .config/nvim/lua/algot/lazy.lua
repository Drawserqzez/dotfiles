local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim',
        '--branch=stable',
        lazypath,
    }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
    -- telescope plugins
    {
        'nvim-telescope/telescope.nvim',
        event = 'VeryLazy',
        config = function()
            require('algot.config.telescope')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'nvim-telescope/telescope-symbols.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
            'nvim-lua/plenary.nvim',
        },
    },

    -- treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        event = 'VeryLazy',
        build = ':TSUpdate',
        config = function()
            require('algot.config.treesitter')
        end
    },

    -- lsp stuff
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = function()
            require('algot.config.lsp')
        end,
        dependencies = {
            -- lspconfig
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- autocompletion
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            -- Snippets
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',
        }
    },
    {
        'mfussenegger/nvim-dap'
    },
    {
        'onsails/lspkind.nvim'
    },
    {
        'rmagatti/goto-preview',
        config = function()
            require('algot.config.gotoPreview')
        end,
    },

    -- buffers and powerline
    {
        'akinsho/bufferline.nvim',
        version = '*',
        config = function()
            require('algot.config.bufferline')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('algot.config.lualine')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    },

    -- navigation
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        config = function()
            require('algot.config.harpoon')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
    },

    -- startview
    {
        'goolord/alpha-nvim',
        config = function()
            require('algot.config.startscreen')
        end
    },

    -- diagnostics + todos
    {
        'folke/trouble.nvim',
        config = function()
            require('algot.config.trouble')
        end,
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        }
    },
    {
        'folke/todo-comments.nvim',
        config = function()
            require('algot.config.todos')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },

    -- colourscheme
    -- {
    --     'rebelot/kanagawa.nvim',
    --     config = function()
    --         require('algot.config.kanagawa')
    --     end,
    -- },
    {
        'rose-pine/neovim', 
        as = 'rose-pine',
        config = function()
            require('algot.config.rose-pine')
        end,
    },

    {
        'lewis6991/gitsigns.nvim',
        event = 'VeryLazy',
        config = function()
            require('algot.config.gitsigns')
        end,
    },

    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        config = function()
            require('algot.config.noice')
        end,
        dependencies = {
            'hrsh7th/nvim-cmp',
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        }
    },

    -- todo: add copilot to work-config
    -- {
    --     'zbirenbaum/copilot.lua'
    -- },
    -- {
    --     'zbirenbaum/copilot-cmp',
    --     dependencies = { 
    --         'zbirenbaum/copilot.lua' 
    --     },
    -- }
}

