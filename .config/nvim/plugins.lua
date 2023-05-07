require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'navarasu/onedark.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'folke/which-key.nvim'

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- Code formatting
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'simrat39/symbols-outline.nvim'

    -- snippet support
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'

    -- File lookup
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use 'nvim-lua/plenary.nvim'

    -- File explorer
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    use {"akinsho/toggleterm.nvim", tag = '*'}

    -- harpoon
    use 'ThePrimeagen/harpoon'

    -- Editor smoothness
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'
    use 'mbbill/undotree'
    use 'karb94/neoscroll.nvim'

    -- For git blame
    use 'tpope/vim-fugitive'
    use 'airblade/vim-gitgutter'

    use 'mexok/voice-command.nvim'

end)

require('voice-command').setup()

require('nvim-tree').setup()

require("telescope").setup({
    defaults = {
        layout_strategy = "horizontal"
    },
    pickers = {
        find_files = {
            theme = "ivy"
        },
        live_grep = {
            theme = "ivy"
        },
        buffers = {
            theme = "ivy"
        },
        help_tags = {
            theme = "ivy"
        },
        marks = {
            theme = "ivy"
        },
    }
})

require('neoscroll').setup()

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
    },
})

require("toggleterm").setup({
    start_in_insert = false,
})
