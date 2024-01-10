require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "python", "perl", "lua", "vim", "go" },
  sync_install = true,
  auto_install = true,
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {enable = true},
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
        ["ih"] = { query = "@conditional.inner", desc = "Select inner part of a condition region" },
        ["ah"] = { query = "@conditional.outer", desc = "Select outer part of a condition region" },
        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
        ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
        ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
      }
    },
    swap = {
      enable = true,
      swap_next = {
          ['<leader>l'] = '@parameter.inner',
      },
      swap_previous = {
          ['<leader>h'] = '@parameter.inner',
      }
    }
  }
}

require("symbols-outline").setup()
