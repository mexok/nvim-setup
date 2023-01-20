require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'ayu-theme/ayu-vim'

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

    -- snippet support
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use "rafamadriz/friendly-snippets"

    -- File lookup
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use 'nvim-lua/plenary.nvim'

    -- File explorer
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- Editor smoothness
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'
    use 'mbbill/undotree'

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
        marks = {
            theme = "ivy"
        },
    }
})
