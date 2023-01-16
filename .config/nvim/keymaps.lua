vim.keymap.set("n", "<leader> ", " ", { noremap = true })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true })
vim.keymap.set("n", "<leader>r", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.keymap.set("v", "<leader>r", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').find_files({ default_text = tmp })<cr>", { noremap = true })
vim.keymap.set("n", "<leader>f", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.keymap.set("v", "<leader>f", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').live_grep({ default_text = tmp })<cr>", { noremap = true })
vim.keymap.set("n", "<leader>j", "<cmd>lua require('telescope.builtin').marks()<cr>", { noremap = true })
vim.keymap.set("v", "<leader>j", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').marks({ default_text = tmp })<cr>", { noremap = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>Git blame<cr>", { noremap = true })
vim.keymap.set("n", "<leader>a", "gg0vG$", { noremap = true })
vim.keymap.set("n", "<leader>tv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>")
vim.keymap.set("n", "<leader>H", ":h ", { noremap = true })
vim.keymap.set({"n", "v"}, "s", "\"_s", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>l", "<cmd>lua vim.cmd(':'..vim.v.count)<cr>", { noremap = true })
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", {noremap=true})

-- debugging
local reg_cmd = "<cmd>let $REG_A = @a<cr><cmd>let $REG_S = @s<cr><cmd>let $REG_D = @d<cr><cmd>let $REG_F = @f<cr>"
vim.keymap.set("n", "<F3>", reg_cmd .. "<cmd>lua require'dap'.run_last()<cr>", { silent = true })
vim.keymap.set("n", "<F4>", reg_cmd .. "<cmd>lua require'dap'.terminate()<cr>", { silent = true })
vim.keymap.set("n", "<F5>", reg_cmd .. "<cmd>lua require'dap'.continue()<cr>", { silent = true })
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", { silent = true })
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { silent = true })
vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", { silent = true })
vim.keymap.set("n", "<leader>i", "<cmd>lua require'dap'.down()<cr>", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>lua require'dap'.up()<cr>", { silent = true })
vim.keymap.set("n", "<leader>m", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
vim.keymap.set("n", "<leader>M", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { silent = true })

vim.keymap.set("n", "<leader>tr", "<cmd>lua require'dap'.repl.toggle()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>tb", "<cmd>lua require'dap'.list_breakpoints()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>tc", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>te", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').expressions).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>tf", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').frames).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').threads).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tg", vim.cmd.Git)

-- lsp setup
local bufopts = { noremap=true, silent=true }
vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<leader>ö', function() vim.lsp.buf.format { async = true } end, bufopts)
vim.keymap.set('n', '<leader>th', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '<leader>tl', vim.diagnostic.setloclist, bufopts)

-- editing
vim.keymap.set("i", "<A-w>", "<right><esc>wi")
vim.keymap.set("i", "<A-W>", "<right><esc>Wi")
vim.keymap.set("i", "<A-e>", "<esc>ea")
vim.keymap.set("i", "<A-E>", "<esc>Ea")
vim.keymap.set("i", "<A-b>", "<right><esc>bi")
vim.keymap.set("i", "<A-B>", "<right><esc>Bi")

vim.keymap.set("i", "<A-a>", "<right><esc>", { noremap=true })
vim.keymap.set("i", "<A-i>", "<esc>", { noremap=true })
vim.keymap.set("i", "<A-d>", "<del>", { noremap=true })
vim.keymap.set("i", "<A-l>", "<right>", { noremap=true })
vim.keymap.set("i", "<A-h>", "<left>", { noremap=true })
vim.keymap.set("n", "<A-p>", "<C-R>\"", {noremap = true})

vim.keymap.set("n", "<A-j>", "<Down>", {noremap = true})
vim.keymap.set("n", "<A-k>", "<Up>", {noremap = true})
vim.keymap.set("n", "<A-h>", "<Left>", {noremap = true})
vim.keymap.set("n", "<A-l>", "<Right>", {noremap = true})

vim.keymap.set("i", "\"<cr>", "\"<cr>\"<ESC>O", { noremap=true })
vim.keymap.set("i", "\"[", "\"\"\"<cr>\"\"\"<ESC>O", { noremap=true })
vim.keymap.set("i", "'<cr>", "'<cr>'<ESC>O", { noremap=true })
vim.keymap.set("i", "'[", "'''<cr>'''<ESC>O", { noremap=true })
vim.keymap.set("i", "(<cr>", "(<cr>)<ESC>O", { noremap=true })
vim.keymap.set("i", "[<cr>", "[<cr>]<ESC>O", { noremap=true })
vim.keymap.set("i", "{<cr>", "{<cr>}<ESC>O", { noremap=true })

vim.keymap.set({"n", "v"}, "<leader>p", "\"+p", { noremap=true })
vim.keymap.set({"n", "v"}, "<leader>P", "\"+P", { noremap=true })
vim.keymap.set({"n", "v"}, "<leader>z", "\"+yl", { noremap=true })
vim.keymap.set({"n", "v"}, "<leader>Z", "\"+Y", { noremap=true })

vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "L", "vloho", {noremap = true})
vim.keymap.set("n", "H", "vholo", {noremap = true})
vim.keymap.set("v", "L", "loho", {noremap = true})
vim.keymap.set("v", "H", "holo", {noremap = true})

vim.keymap.set("n", "<leader>s", ":%s/", {noremap = true})
vim.keymap.set("v", "<leader>s", ":s/", {noremap = true})
vim.keymap.set("n", "<leader>g", ":%g/", {noremap = true})
vim.keymap.set("v", "<leader>g", ":g/", {noremap = true})
vim.keymap.set("n", "<leader>v", ":%v/", {noremap = true})
vim.keymap.set("v", "<leader>v", ":v/", {noremap = true})

vim.keymap.set({"n", "v"}, "x", "V", {noremap = true})

vim.cmd([[
fun! SetKeymaps()
    nnoremap <nowait><buffer> d x
    nnoremap <nowait><buffer> c viw
    vnoremap <nowait><buffer> c <esc>viw
    nnoremap <nowait><buffer> C viW
    vnoremap <nowait><buffer> C <esc>viW
    nnoremap <nowait><buffer> yy zz
    vnoremap <nowait><buffer> yy zz
    nnoremap <nowait><buffer> y= z=
    vnoremap <nowait><buffer> y= z=
    nnoremap <nowait><buffer> z yl
    vnoremap <nowait><buffer> z y
    nnoremap <leader>cr <Plug>(abolish-coerce-word)
    nnoremap <leader>ds <Plug>Dsurround
    nnoremap <leader>cs <Plug>Csurround
    nnoremap <leader>cS <Plug>CSurround
    xnoremap S <Plug>VSurround
    xnoremap gs <Plug>VgSurround
endfun

augroup set_keymaps
    autocmd!
    autocmd FileType * :call SetKeymaps()
augroup end
]])
