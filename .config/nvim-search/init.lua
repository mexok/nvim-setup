local set = vim.keymap.set

vim.g.mapleader = " "
vim.g.python3_host_prog = 'python3'
vim.g.lightspeed_no_default_keymaps = true
vim.g.surround_no_mappings = true
vim.g.gitgutter_show_msg_on_hunk_jumping = 0

vim.opt.laststatus = 0
vim.opt.cmdheight = 0

vim.opt.iskeyword:append({"$", "@-@", "%"})

vim.opt.exrc = true
vim.opt.foldmethod="expr"
vim.opt.foldlevel = 99
vim.opt.hlsearch = true
vim.opt.hidden = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.incsearch = true

vim.opt.colorcolumn = "80"

set("n", "<esc>", "<cmd>q!<cr>", { noremap=true, desc="use esc to quit" })

-- editing
local kwords = "A-Za-z0-9_$%@äöüÄÖÜß"

local search_word_forward_begin = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)['..kwords..']", "e", vim.fn.line("w$")) end<cr>'
local search_word_forward_end = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("['..kwords..']\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)", "", vim.fn.line("w$")) end<cr>'
local search_word_backward_begin = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("\\\\(^\\\\|\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)['..kwords..']", "be", vim.fn.line("w0")) end<cr>'
local search_word_backward_end = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("['..kwords..']\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)", "b", vim.fn.line("w0")) end<cr>'

set({"n", "x"}, "ge", "E", { noremap = true })
set({"n", "x"}, "e", search_word_forward_end, { noremap = true })
set({"n", "x"}, "E", search_word_forward_begin, { noremap = true })
set("i", "<A-e>", "<esc>"..search_word_forward_end.."a", { noremap = true })
set("i", "<A-E>", "<esc>"..search_word_forward_begin.."a", { noremap = true })

set({"n", "x"}, "gb", "B", { noremap = true })
set({"n", "x"}, "b", search_word_backward_begin, { noremap = true })
set({"n", "x"}, "B", search_word_backward_end, { noremap = true })
set("i", "<A-b>", "<right><esc>"..search_word_backward_begin.."i", { noremap = true })
set("i", "<A-B>", "<right><esc>"..search_word_backward_end.."i", { noremap = true })

set("i", "<A-L>", "<esc>Ea")
set("i", "<A-H>", "<right><esc>Bi")

set("i", "<A-a>", "<right><esc>", { noremap=true })
set("i", "<A-i>", "<esc>", { noremap=true })


set("n", "gp", "`[v`]", { desc="select pasted text in visual mode" })
set("x", "gp", "<esc>`[v`]", { desc="select pasted text in visual mode" })
set({"n", "v"}, "<leader>p", "\"+p", { noremap=true, desc="p using global buffer" })
set({"n", "v"}, "<leader>P", "\"+P", { noremap=true, desc="P using global buffer" })
set({"n", "v"}, "<leader>y", "\"+yl", { noremap=true, desc="y using global buffer" })
set({"n", "v"}, "<leader>Y", "\"+Y", { noremap=true, desc="Y using global buffer" })
set({"n", "v"}, "<leader>d", "\"+x", { noremap=true, desc="d using global buffer" })

set("n", "J", "v:m '>+1<cr>gv=", {noremap=true})
set("n", "K", "v:m '<-2<cr>gv=", {noremap=true})
set("x", "J", ":m '>+1<cr>gv=gv", {noremap=true})
set("x", "K", ":m '<-2<cr>gv=gv", {noremap=true})
set("n", "L", ">>", {noremap = true})
set("n", "H", "<<", {noremap = true})
set("x", "L", ">gv", {noremap=true})
set("x", "H", "<gv", {noremap=true})

set("i", "<C-l>", "<right>", {noremap=true})
set("i", "<C-h>", "<left>", {noremap=true})

set({"n", "x"}, "<C-j>", "J", {noremap=true})


vim.cmd([[
fun! SetMotionsKeymaps()
    nnoremap <nowait><buffer> d x
    xnoremap <nowait><buffer> d x
    nnoremap <nowait><buffer> D "_D
    xnoremap <nowait><buffer> D "_x
    nnoremap <nowait><buffer> s "_s
    xnoremap <nowait><buffer> s "_s
    nnoremap <nowait><buffer> c viw
    xnoremap <nowait><buffer> c <esc>viw
    nnoremap <nowait><buffer> C viW
    xnoremap <nowait><buffer> C <esc>viW
    nnoremap <nowait><buffer> x V
    xnoremap <nowait><buffer> x vvV
    nnoremap <nowait><buffer> V v$<left>
    xnoremap <nowait><buffer> V $<left>
    nnoremap <nowait><buffer> y "+yl<cmd>q!<cr>
    nnoremap <nowait><buffer> Y v$<left>"+y<cmd>q!<cr>
    xnoremap <nowait><buffer> y "+y<cmd>q!<cr>
endfun

augroup set_motions_keymaps
    autocmd!
    autocmd BufRead,BufNewFile,FilterReadPre,FileReadPre * :call SetMotionsKeymaps()
    autocmd FileType * :call SetMotionsKeymaps()
augroup end

call SetMotionsKeymaps()

fun! TrimWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup trim_whitespaces
    autocmd!
    autocmd BufRead * :call TrimWhitespaces()
augroup end
]])



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

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    },
    'nvim-treesitter/nvim-treesitter-textobjects',
    'simrat39/symbols-outline.nvim',
}

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

require('onedark').setup {
    style = 'darker',
    transparent = true,
    term_colors = true,

    highlights = {
        NvimTreeNormal = { fg = "#a0a8b7", bg = "#282c34" },
        NvimTreeNormalFloat = { fg = "#a0a8b7", bg = "#282c34" }
    }
}
require('onedark').load()
