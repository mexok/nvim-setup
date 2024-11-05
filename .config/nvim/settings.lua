vim.g.mapleader = " "
vim.g.python3_host_prog = 'python3'
vim.g.lightspeed_no_default_keymaps = true
vim.g.surround_no_mappings = true

vim.opt.iskeyword:append({"$", "@-@", "%"})

vim.opt.exrc = true
vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
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

vim.cmd [[
filetype plugin indent on
]]
