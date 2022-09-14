vim.keymap.set("n", "<A-q>", "<cmd>q<cr>", { noremap = true })
vim.keymap.set("n", "<A-w>", "<cmd>w<cr>", { noremap = true })

vim.keymap.set("n", "<F1>", "<cmd>VimspectorReset<cr>", { noremap = true })

vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { noremap = true })

vim.keymap.set("i", "<A-d>", "<Esc>", { noremap = true })

vim.cmd([[
inoremap <expr> <A-l> coc#pum#visible() ? coc#pum#confirm() : "\<A-l>"
inoremap <expr> <A-ö> coc#pum#visible() ? "<Esc>" : "\<A-ö>"
inoremap <expr> <A-j> coc#pum#visible() ? coc#pum#next(1) : "\<A-j>"
inoremap <expr> <A-k> coc#pum#visible() ? coc#pum#prev(1) : "\<A-k>"
]])

vim.keymap.set("i", "<A-h>", "coc#refresh()")
vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)")

vim.keymap.set("n", "gd", "<Plug>(coc-definition)")
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)")
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)")
vim.keymap.set("n", "gr", "<Plug>(coc-references)")

vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true })

vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { noremap = true })

vim.keymap.set("n", ",", ";")
vim.keymap.set("n", ";", ",")

vim.keymap.set("n", "<A-o>", "m`o<Esc>``", { noremap = true })
vim.keymap.set("n", "<A-O>", "m`O<Esc>``", { noremap = true })

-- AltGr + asdfg for buffers
vim.keymap.set({"n", "v"}, "æ", '"a', { noremap = true })
vim.keymap.set({"n", "v"}, "ſ", '"s', { noremap = true })
vim.keymap.set({"n", "v"}, "ð", '"d', { noremap = true })
vim.keymap.set({"n", "v"}, "đ", '"f', { noremap = true })
vim.keymap.set({"n", "v"}, "ŋ", '"g', { noremap = true })
-- AltGr + r for list of registers
vim.keymap.set({"n", "v"}, "¶", ":registers<CR>", { noremap = true })

vim.keymap.set("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.keymap.set("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
vim.keymap.set("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
vim.keymap.set("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })

