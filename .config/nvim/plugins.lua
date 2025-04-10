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
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {},
    },
    'HiPhish/rainbow-delimiters.nvim',

    -- Debugging
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-jdtls',

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
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'nvim-telescope/telescope-live-grep-args.nvim',
        }
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
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
    'tpope/vim-sleuth',
    'tpope/vim-sensible',

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

local harpoon = require("harpoon")
harpoon:setup()


local actions = require("telescope.actions")
local lga_actions = require("telescope-live-grep-args.actions")
require("telescope").setup {
    defaults = {
        layout_strategy = "horizontal",
        path_display = function(opts, path)
            local tail = require("telescope.utils").path_tail(path)
            return string.format("%s -> %s", tail, path)
        end,
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--hidden",
            "--with-filename",
            "--line-number",
            "--iglob",
            "!.git",
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
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },

        live_grep_args = {
              auto_quoting = true, -- enable/disable auto-quoting
              -- define mappings, e.g.
              mappings = { -- extend mappings
                i = {
                  ["<C-k>"] = lga_actions.quote_prompt(),
                  ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                  ["<C-space>"] = actions.to_fuzzy_refine,
                },
              },
        }
    }
}
require('telescope').load_extension('fzf')
require("telescope").load_extension("live_grep_args")

require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = {
        "lua_ls",
        "perlnavigator",
    },
}

local neoscroll = require('neoscroll')
neoscroll.setup({mappings = {}})

local keymap = {
  ["<PageUp>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
  ['<up>'] = function() neoscroll.ctrl_b({ duration = 250 }) end;
  ["<PageDown>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
  ['<down>'] = function() neoscroll.ctrl_f({ duration = 250 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end

require("toggleterm").setup {
    start_in_insert = false,
}

require("oil").setup {}
