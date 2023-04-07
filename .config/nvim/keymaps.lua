local set = vim.keymap.set
set("n", "<leader> ", " ", { noremap = true, desc = "escape leader"})
set("n", "<leader>q", "<cmd>q<cr>", { noremap = true, desc = "quit" })
set("n", "<leader>w", "<cmd>w<cr>", { noremap = true, desc = "write" })
set("n", "<leader>r", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, desc = "search files in project" })
set("v", "<leader>r", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').find_files({ default_text = tmp })<cr>", { noremap = true, desc = "search files in project with marked text"})
set("n", "<leader>f", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true, desc = "search text in project" })
set("v", "<leader>f", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').live_grep({ default_text = tmp })<cr>", { noremap = true, desc = "search marked text in project"})
set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "explorer"})
set("n", "<leader>b", "<cmd>Git blame<cr>", { desc = "git blame"})
set("n", "<leader>a", "gg0vG$", { noremap = true, desc = "select all"})
set("n", "<leader>tv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>", { desc = "use python vulture for src dir" })
set("n", "<leader>H", ":h ", { noremap = true, desc = "help" })
set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap = true, desc = "toggle undotree" })

-- debugging
local reg_cmd = "<cmd>let $REG_A = @a<cr><cmd>let $REG_S = @s<cr><cmd>let $REG_D = @d<cr><cmd>let $REG_F = @f<cr>"
set("n", "<F3>", reg_cmd .. "<cmd>lua require'dap'.run_last()<cr>", { silent = true, desc = "run last" })
set("n", "<F4>", reg_cmd .. "<cmd>lua require'dap'.terminate()<cr>", { silent = true, desc = "terminate" })
set("n", "<F5>", reg_cmd .. "<cmd>lua require'dap'.continue()<cr>", { silent = true, desc = "continue" })
set("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", { silent = true, desc = "step over"})
set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { silent = true, desc = "step into"})
set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", { silent = true, desc = "step out" })
set("n", "<leader>i", "<cmd>lua require'dap'.down()<cr>", { silent = true, desc = "debugger down" })
set("n", "<leader>o", "<cmd>lua require'dap'.up()<cr>", { silent = true, desc = "debugger up" })
set("n", "<leader>m", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true, desc = "toggle breakpoint"})
set("n", "<leader>M", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { silent = true, desc = "ste breakpoint condition"})
set("n", "<leader>h", ":lua require'dap.ui.widgets'.hover()<cr>", { silent = true, desc = "debugger hover word"})

set("n", "<leader>tr", "<cmd>lua require'dap'.repl.toggle()<cr>", { noremap=true, desc = "toggle repl" })
set("n", "<leader>tb", "<cmd>lua require'dap'.list_breakpoints()<cr>", { noremap=true, desc = "list breakpoints"})
set("n", "<leader>tc", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { noremap=true, desc = "clear breakpoints"})
set("n", "<leader>te", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').expressions).open()<cr>", { silent = true, desc = "open debug expressions"})
set("n", "<leader>tf", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').frames).open()<cr>", { silent = true, desc = "open debug frames"})
set("n", "<leader>tt", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').threads).open()<cr>", { silent = true, desc = "open debug threads"})
set("n", "<leader>ts", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<cr>", { silent = true, desc = "open debug scopes"})
set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true, desc = "update plugins"})
set("n", "<leader>tg", vim.cmd.Git, {desc = "open git"})
set("n", "<leader>to", "<cmd>SymbolsOutline<cr>")
set("n", "<leader>k", "<cmd>ToggleTerm<cr>")
set("n", "<leader>j", ":ToggleTermSendCurrentLine<cr>")
set("v", "<leader>j", ":ToggleTermSendVisualSelection<cr>")

-- lsp setup
set('n', 'gs', vim.lsp.buf.declaration, { noremap=true, silent=true, desc="go to declaration" })
set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true, desc="go to definition" })
set('n', 'gh', vim.lsp.buf.hover, { noremap=true, silent=true, desc="hover" })
set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true, desc="go to implementation" })
set('n', 'gk', vim.lsp.buf.signature_help, { noremap=true, silent=true, desc="show signature help" })
set('n', '<leader>n', vim.lsp.buf.rename, { noremap=true, silent=true, desc="rename" })
set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true, desc="show references" })
set('n', '<leader>ö', function() vim.lsp.buf.format { async = false } end, { noremap=true, silent=true, desc="format file"})
set('n', '<leader>th', vim.diagnostic.open_float, { noremap=true, silent=true, desc="show diagnostics"})
set('n', '<leader>tl', vim.diagnostic.setloclist, { noremap=true, silent=true, desc="diagnostics quicklist"})
set('n', ']t', vim.diagnostic.goto_next, { noremap=true, silent=true, desc="diagnostics next"})
set('n', '[t', vim.diagnostic.goto_prev, { noremap=true, silent=true, desc="diagnostics previous"})


-- editing
set("i", "<A-w>", "<right><esc>wi")
set("i", "<A-W>", "<right><esc>Wi")
set("i", "<A-e>", "<esc>ea")
set("i", "<A-E>", "<esc>Ea")
set("i", "<A-b>", "<right><esc>bi")
set("i", "<A-B>", "<right><esc>Bi")

set("i", "<A-a>", "<right><esc>", { noremap=true })
set("i", "<A-i>", "<esc>", { noremap=true })
set("i", "<A-d>", "<del>", { noremap=true })
set("i", "<A-l>", "<right>", { noremap=true })
set("i", "<A-h>", "<left>", { noremap=true })
set({"v", "n"}, "<A-d>", "\"_x", { noremap=true })


set({"n", "v"}, "<leader>p", "\"+p", { noremap=true, desc="p using global buffer" })
set({"n", "v"}, "<leader>P", "\"+P", { noremap=true, desc="P using global buffer" })
set({"n", "v"}, "<leader>z", "\"+yl", { noremap=true, desc="z using global buffer" })
set({"n", "v"}, "<leader>Z", "\"+Y", { noremap=true, desc="Z using global buffer" })
set({"n", "v"}, "<leader>d", "\"+x", { noremap=true, desc="d using global buffer" })
set({"n", "v"}, "<leader>D", "\"+D", { noremap=true, desc="D using global buffer" })

set("v", "J", ":m '>+1<cr>gv=gv")
set("v", "K", ":m '<-2<cr>gv=gv")

set("n", "L", "vloho", {noremap = true})
set("n", "H", "vholo", {noremap = true})
set("v", "L", "loho", {noremap = true})
set("v", "H", "holo", {noremap = true})

set({"n", "v"}, "ü", "p", {noremap = true})
set("v", "p", "P", {noremap = true})

set("n", "ö", 'vi"', {noremap = true})
set("n", "Ö", 'vi"f"oF"o', {noremap = true})
set("v", "ö", '<esc>vi"', {noremap = true})
set("v", "Ö", '<esc>vi"f"oF"o', {noremap = true})
set("n", "ä", "vi'", {noremap = true})
set("n", "Ä", "vi'f'oF'o", {noremap = true})
set("v", "ä", "<esc>vi'", {noremap = true})
set("v", "Ä", "<esc>vi'f'oF'o", {noremap = true})

set("n", "<C-j>", "<C-v>j", {noremap = true})
set("v", "<C-j>", "j", {noremap = true})
set("n", "<C-k>", "<C-v>k", {noremap = true})
set("v", "<C-k>", "k", {noremap = true})
set("n", "<C-h>", "<C-v>h", {noremap = true})
set("v", "<C-h>", "h", {noremap = true})
set("n", "<C-l>", "<C-v>l", {noremap = true})
set("v", "<C-l>", "l", {noremap = true})

set("n", "<A-j>", "<Down>")
set("n", "<A-k>", "<Up>")
set("n", "<A-h>", "<Left>")
set("n", "<A-l>", "<Right>")

set("n", "<leader>s", ":%s/", {noremap = true})
set("v", "<leader>s", ":s/", {noremap = true})
set("n", "<leader>g", ":%g/", {noremap = true})
set("v", "<leader>g", ":g/", {noremap = true})
set("n", "<leader>v", ":%v/", {noremap = true})
set("v", "<leader>v", ":v/", {noremap = true})

set({"n", "v"}, ".", ";", {noremap = true})
set({"n", "v"}, ";", ".", {noremap = true})

set("n", "<tab>", ">>", {noremap = true})
set("n", "<S-tab>", "<<", {noremap = true})
set("v", '<tab>', '>gv', {noremap=true})
set("v", '<S-tab>', '<gv', {noremap=true})

set({"n", "v"}, "<A-3>", "0", { noremap = true })
set({"n", "v"}, "<A-4>", "$", { noremap = true })
set({"n", "v"}, "0", "_", { noremap = true })
set("i", "<A-3>", "<esc>0i", { noremap = true })
set("i", "<A-4>", "<esc>$a", { noremap = true })
set("i", "<A-0>", "<esc>_i", { noremap = true })

set("i", "\"<cr>", "\"<cr>\"<ESC>O", { noremap=true })
set("i", "\"[", "\"\"\"<cr>\"\"\"<ESC>O", { noremap=true })
set("i", "\"+", "\" +<cr>\"", { noremap=true })
set("i", "'<cr>", "'<cr>'<ESC>O", { noremap=true })
set("i", "'[", "'''<cr>'''<ESC>O", { noremap=true })
set("i", "'+", "' +<cr>'", { noremap=true })
set("i", "(<cr>", "(<cr>)<ESC>O", { noremap=true })
set("i", "[<cr>", "[<cr>]<ESC>O", { noremap=true })
set("i", "{<cr>", "{<cr>}<ESC>O", { noremap=true })


vim.cmd([[
fun! SetKeymaps()
    nnoremap <nowait><buffer> d x
    vnoremap <nowait><buffer> d x
    nnoremap <nowait><buffer> s "_s
    vnoremap <nowait><buffer> s "_s
    nnoremap <nowait><buffer> c viw
    vnoremap <nowait><buffer> c <esc>viw
    nnoremap <nowait><buffer> C viW
    vnoremap <nowait><buffer> C <esc>viW
    nnoremap <nowait><buffer> x V
    vnoremap <nowait><buffer> x vvV
    vnoremap <nowait><buffer> v <esc>
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
