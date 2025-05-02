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
]])
