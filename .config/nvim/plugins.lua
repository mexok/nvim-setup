require('packer').startup(function(use)
    -- package manager
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'agude/vim-eldar'

    -- Debugging
    use 'puremourning/vimspector'

    -- Code completion
    use { 'neoclide/coc.nvim', branch = 'release' }

    -- File lookup
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use 'nvim-lua/plenary.nvim'  -- Needed for telescope

    -- File explorer
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'

    -- Editor smoothness
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'David-Kunz/treesitter-unit'

    -- For git blame
    use 'tpope/vim-fugitive'

    -- For better indentation
    use 'Vimjas/vim-python-pep8-indent'

    use 'mexok/voice-command.nvim'

end)

require('voice-command').setup()

require('nvim-autopairs').setup({
  disable_filetype = { 'TelescopePrompt' },
})

require('nvim-tree').setup()

require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "python", "typescript", "javascript"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})

