require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'navarasu/onedark.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'folke/which-key.nvim'

    -- Debugging
    use 'mfussenegger/nvim-dap'

    -- Code completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'simrat39/symbols-outline.nvim'

    -- snippet support
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'honza/vim-snippets'

    -- File lookup
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope-live-grep-args.nvim'

    -- File explorer
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-tree/nvim-tree.lua'

    -- Terminal
    use { "akinsho/toggleterm.nvim", tag = '*' }

    -- Editor smoothness
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'
    use 'tpope/vim-unimpaired'
    use 'AndrewRadev/splitjoin.vim'
    use 'karb94/neoscroll.nvim'

    -- Git
    use 'tpope/vim-fugitive'  -- only for git blame
    use 'airblade/vim-gitgutter'

    use 'mexok/voice-command.nvim'
    use 'mexok/motions.nvim'
    use 'mexok/reglist.nvim'

end)

require('reglist').setup {
    default_mappings = '<leader>l',
    regnames = {
        "a",  --  1
        "b",  --  2
        "c",  --  3
        "d",  --  4
        "e",  --  5
        "f",  --  6
        "g",  --  7
        "h",  --  8
        "i",  --  9
        "j",  -- 10
        "l",  -- 11
        "k",  -- 12
        "m",  -- 13
        "n",  -- 14
        "o",  -- 15
    }
}

require('motions').setup()

require('voice-command').setup()

require('nvim-tree').setup({
    update_focused_file = {
        enable = true,
    }
})

require("telescope").setup {
    defaults = {
        layout_strategy = "horizontal",
        hidden = true,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        }
    },
    pickers = {
        find_files = {
            theme = "ivy"
        },
        live_grep = {
            theme = "ivy",
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
}

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "perlnavigator",
        "gopls",
    },
}

require('neoscroll').setup()

local t = {}
t['<PageUp>'] = {'scroll', {'-vim.wo.scroll', 'true', '250'}}
t['<PageDown>'] = {'scroll', {'vim.wo.scroll', 'true', '250'}}

require('neoscroll.config').set_mappings(t)

require("toggleterm").setup {
    start_in_insert = false,
}
