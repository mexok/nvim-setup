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
                ['<leader>~pn'] = '@parameter.inner',
                ['<leader>~fn'] = '@function.outer',
            },
            swap_previous = {
                ['<leader>~pp'] = '@parameter.inner',
                ['<leader>~fp'] = '@function.outer',
            }
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]f"] = { query = "@function.outer", desc = "Next function start"},
                ["]b"] = { query = "@function.inner", desc = "Next function body start"},
                ["]c"] = { query = "@class.outer", desc = "Next class start" },
                ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                ["]o"] = { query = "@conditional.outer", desc = "Next conditional start" },
            },
            goto_next_end = {
                ["]F"] = { query = "@function.outer", desc = "Next function end"},
                ["]B"] = { query = "@function.inner", desc = "Next function body start"},
                ["]C"] = { query = "@class.outer", desc = "Next class end" },
                ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                ["]O"] = { query = "@conditional.outer", desc = "Next conditional end" },
            },
            goto_previous_start = {
                ["[f"] = { query = "@function.outer", desc = "Previous function start"},
                ["[b"] = { query = "@function.inner", desc = "Previous function body start"},
                ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
                ["[o"] = { query = "@conditional.outer", desc = "Previous conditional start" },
            },
            goto_previous_end = {
                ["[F"] = { query = "@function.outer", desc = "Previous function end"},
                ["[B"] = { query = "@function.inner", desc = "Previous function body end"},
                ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
                ["[O"] = { query = "@conditional.outer", desc = "Previous conditional end" },
            },
        }
    }
}

require("symbols-outline").setup()
