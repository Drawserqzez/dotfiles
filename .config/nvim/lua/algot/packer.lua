-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim' -- todo: auto-clone packer if not present
    

    use {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.3',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use { 
        'nvim-telescope/telescope-ui-select.nvim',
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('nvim-tree/nvim-web-devicons')

    -- lsp config
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use 'mfussenegger/nvim-dap'

    use('onsails/lspkind.nvim')

    use {
        'rmagatti/goto-preview'
    }

    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    use {
        'goolord/alpha-nvim',
    }

    use {
        'folke/trouble.nvim',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    use {
        'folke/todo-comments.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    use('rebelot/kanagawa.nvim')

    use { 
        "zbirenbaum/copilot.lua", 
    }

    use {
       'zbirenbaum/copilot-cmp',
       after = { 'copilot.lua' },
    }
end)
