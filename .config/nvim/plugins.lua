local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup {
    -- Theme
    'navarasu/onedark.nvim',
    'nvim-lualine/lualine.nvim',
    'folke/which-key.nvim',

    -- Debugging
    'mfussenegger/nvim-dap',

    -- Code completion
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'windwp/nvim-ts-autotag',
    'simrat39/symbols-outline.nvim',
    'elubow/cql-vim',

    -- snippet support
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'honza/vim-snippets',

    -- File lookup
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-live-grep-args.nvim',
        }
    },

    -- File explorer
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'stevearc/oil.nvim',

    -- Terminal
    {'akinsho/toggleterm.nvim', version = "*", config = true},

    -- Editor smoothness
    'tpope/vim-surround',
    'tpope/vim-commentary',
    'tpope/vim-abolish',
    'AndrewRadev/splitjoin.vim',
    'karb94/neoscroll.nvim',

    -- Git
    'tpope/vim-fugitive',
    'airblade/vim-gitgutter',

    'mexok/voice-command.nvim',
    'mexok/motions.nvim',
    'mexok/reglist.nvim'
}

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


local function on_attach_nvim_tree(bufnr)
    local api = require "nvim-tree.api"
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set({'n', 'x'}, ']g', require('nvim-tree.api').node.navigate.git.next, opts('Git next'))
    vim.keymap.set({'n', 'x'}, '[g', require('nvim-tree.api').node.navigate.git.prev, opts('Git previous'))
    vim.keymap.set({'n', 'x'}, ']d', require('nvim-tree.api').node.navigate.diagnostics.next, opts('Diagnostics next'))
    vim.keymap.set({'n', 'x'}, '[d', require('nvim-tree.api').node.navigate.diagnostics.prev, opts('Diagnostics previous'))
    vim.keymap.set({'n', 'x'}, ']o', require('nvim-tree.api').node.navigate.opened.next, opts('Opened next'))
    vim.keymap.set({'n', 'x'}, '[o', require('nvim-tree.api').node.navigate.opened.prev, opts('Opened previous'))
    vim.keymap.set({'n', 'x'}, ']m', require('nvim-tree.api').marks.navigate.next, opts('Marks next'))
    vim.keymap.set({'n', 'x'}, '[m', require('nvim-tree.api').marks.navigate.prev, opts('Marks previous'))
end


require("nvim-tree").setup {
    renderer = {
        highlight_diagnostics = true,
        highlight_git = true,
        highlight_opened_files = "all",
    },
    update_focused_file = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true
    },
    on_attach = on_attach_nvim_tree
}

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

require("oil").setup {}
