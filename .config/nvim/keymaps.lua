vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true })
vim.keymap.set("n", "<leader>W", "<cmd>wq<cr>", { noremap = true })
vim.keymap.set("n", "<leader>r", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("v", "<leader>r", "y:Telescope find_files default_text=<C-R>\"<cr>", { noremap = true })
vim.keymap.set("n", "<leader>g", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("v", "<leader>g", "y:Telescope live_grep default_text=<C-R>\"<cr>", { noremap = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>p", "<cmd>PackerUpdate<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>Git blame<cr>", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>c", ":", { noremap = true })
vim.keymap.set("n", "<leader>lv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>")

-- debugging
local reg_cmd = "<cmd>let $REG_A = @a<cr><cmd>let $REG_S = @s<cr><cmd>let $REG_D = @d<cr><cmd>let $REG_F = @f<cr>"
vim.keymap.set("n", "<F3>", reg_cmd .. "<cmd>lua require'dap'.run_last()<cr>", { silent = true })
vim.keymap.set("n", "<F5>", reg_cmd .. "<cmd>lua require'dap'.continue()<cr>", { silent = true })
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", { silent = true })
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { silent = true })
vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", { silent = true })
vim.keymap.set("n", "<leader>i", "<cmd>lua require'dap'.down()<cr>", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>lua require'dap'.up()<cr>", { silent = true })
vim.keymap.set("n", "m", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
vim.keymap.set("n", "M", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { silent = true })

vim.keymap.set("n", "<leader>tr", "<cmd>lua require'dap'.repl.toggle()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>tb", "<cmd>lua require'dap'.list_breakpoints()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>tc", "<cmd>lua require'dap'.clear_breakpoints()<cr>", { noremap=true })
vim.keymap.set("n", "<leader>te", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').expressions).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>tf", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').frames).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>tt", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').threads).open()<cr>", { silent = true })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<cr>", { silent = true })

-- lsp setup
vim.keymap.set('n', '<leader>a', vim.diagnostic.setloclist, { noremap=true, silent=true })

local bufopts = { noremap=true, silent=true, buffer=bufnr }
vim.keymap.set('n', 'gs', vim.lsp.buf.declaration, bufopts)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)

-- editing
vim.keymap.set({"n"}, "w", "viw")
vim.keymap.set({"n"}, "W", "viW")
local kwords = "A-Za-z0-9_"
vim.keymap.set({"n", "o", "v"}, "e", '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("['..kwords..']\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)", "", vim.fn.line("w$")) end<cr>')
vim.keymap.set({"n", "o", "v"}, "b", '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("\\\\(^\\\\|\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)['..kwords..']", "be", vim.fn.line("w0")) end<cr>')

vim.keymap.set("i", "<A-a>", "<esc>", { noremap=true })
vim.keymap.set("i", "<A-i>", "<esc>l", { noremap=true })

-- remappings for better find
vim.cmd([[
function! SetBracketMappings()
    nnoremap <silent><nowait><buffer> [ f[
    vnoremap <silent><nowait><buffer> [ f[
    nnoremap <silent><nowait><buffer> ] f]
    vnoremap <silent><nowait><buffer> ] f]
    nnoremap <silent><nowait><buffer> <leader>[ F[
    vnoremap <silent><nowait><buffer> <leader>[ F[
    nnoremap <silent><nowait><buffer> <leader>] F]
    vnoremap <silent><nowait><buffer> <leader>] F]
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call SetBracketMappings()
augroup END
]])

vim.keymap.set({"n", "v"}, "_", "f_", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>_", "F_", {noremap = true})
vim.keymap.set({"n", "v"}, ":", "f:", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>:", "F:", {noremap = true})
vim.keymap.set({"n", "v"}, "<", "f<", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader><", "F<", {noremap = true})
vim.keymap.set({"n", "v"}, ">", "f>", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>>", "F>", {noremap = true})
vim.keymap.set({"n", "v"}, "{", "f{", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>{", "F{", {noremap = true})
vim.keymap.set({"n", "v"}, "}", "f}", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>}", "F}", {noremap = true})
vim.keymap.set({"n", "v"}, ")", "f)", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>)", "F)", {noremap = true})
vim.keymap.set({"n", "v"}, "(", "f(", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>(", "F(", {noremap = true})
vim.keymap.set({"n", "v"}, ",", "f,", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>,", "F,", {noremap = true})
vim.keymap.set({"n", "v"}, ";", "f;", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>;", "F;", {noremap = true})
vim.keymap.set({"n", "v"}, "-", "f-", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>-", "F-", {noremap = true})
vim.keymap.set({"n", "v"}, "+", "f+", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>+", "F+", {noremap = true})
vim.keymap.set({"n", "v"}, "*", "f*", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>*", "F*", {noremap = true})
vim.keymap.set({"n", "v"}, "#", "f#", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>#", "F#", {noremap = true})
vim.keymap.set({"n", "v"}, ".", "f.", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>.", "F.", {noremap = true})
vim.keymap.set({"n", "v"}, "'", "f'", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>'", "F'", {noremap = true})
vim.keymap.set({"n", "v"}, "\"", "f\"", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>\"", "F\"", {noremap = true})
vim.keymap.set({"n", "v"}, "=", "f=", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>=", "F=", {noremap = true})
vim.keymap.set({"n", "v"}, "!", "f!", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>!", "F!", {noremap = true})
vim.keymap.set({"n", "v"}, "/", "f/", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>/", "F/", {noremap = true})
vim.keymap.set("n", "<leader>f", "/", {noremap = true})
vim.keymap.set("v", "<leader>f", "y/<C-R>\"", {noremap = true})
vim.keymap.set("n", "<leader>s", ":%s/", {noremap = true})
vim.keymap.set("v", "<leader>s", ":s/", {noremap = true})

-- AltGr + asdfg for buffers
vim.keymap.set({"n", "v"}, "æ", '"a', { noremap = true })
vim.keymap.set({"n", "v"}, "ſ", '"s', { noremap = true })
vim.keymap.set({"n", "v"}, "ð", '"d', { noremap = true })
vim.keymap.set({"n", "v"}, "đ", '"f', { noremap = true })
vim.keymap.set({"n", "v"}, "ŋ", '"+', { noremap = true }) -- g for global buffer

vim.keymap.set({"n", "v"}, "←", '"z', { noremap = true })
vim.keymap.set({"n", "v"}, "↓", '"u', { noremap = true })
vim.keymap.set({"n", "v"}, "→", '"i', { noremap = true })
vim.keymap.set({"n", "v"}, "ø", '"o', { noremap = true })
vim.keymap.set({"n", "v"}, "þ", '"p', { noremap = true })

-- AltGr + r for list of registers
vim.keymap.set({"n", "v"}, "¶", ":registers<cr>", { noremap = true })
