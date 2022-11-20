require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'ayu-theme/ayu-vim'

    -- Debugging
    use 'mfussenegger/nvim-dap'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    -- File lookup
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use 'nvim-lua/plenary.nvim'  -- Needed for telescope

    -- File explorer
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    -- Editor smoothness
    use 'kana/vim-smartinput'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- For git blame
    use 'tpope/vim-fugitive'

    -- For better indentation
    use 'Vimjas/vim-python-pep8-indent'

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
    }
})
