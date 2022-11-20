vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true })

vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tl", "<cmd>Telescope live_grep<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>", { noremap = true })
vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>", { noremap = true })

vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { noremap = true })

-- debugging
vim.keymap.set("n", "<F5>", "<cmd>let $REG_A = @a<cr><cmd>let $REG_S = @s<cr><cmd>let $REG_D = @d<cr><cmd>let $REG_F = @f<cr><cmd>lua require'dap'.continue()<cr>", { silent = true })
vim.keymap.set("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", { silent = true })
vim.keymap.set("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", { silent = true })
vim.keymap.set("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", { silent = true })
vim.keymap.set("n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { silent = true })
vim.keymap.set("n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { silent = true })
vim.keymap.set("n", "<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { silent = true })
vim.keymap.set("n", "<leader>tr", "<cmd>lua require'dap'.repl.toggle()<cr>", { silent = true })
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { silent = true })

-- remappings for better find
vim.cmd([[
function! SetBracketMappings()
    nnoremap <silent><nowait><buffer> [ f[
    vnoremap <silent><nowait><buffer> [ f[
    nnoremap <silent><nowait><buffer> ] f]
    vnoremap <silent><nowait><buffer> ] f]
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call SetBracketMappings()
augroup END
]])

vim.keymap.set({"n", "v"}, "{", "f{", {noremap = true})
vim.keymap.set({"n", "v"}, "}", "f}", {noremap = true})
vim.keymap.set({"n", "v"}, ")", "f)", {noremap = true})
vim.keymap.set({"n", "v"}, "(", "f(", {noremap = true})
vim.keymap.set({"n", "v"}, ",", "f,", {noremap = true})
vim.keymap.set({"n", "v"}, ";", "f;", {noremap = true})
vim.keymap.set({"n", "v"}, "-", "f-", {noremap = true})
vim.keymap.set({"n", "v"}, "+", "f+", {noremap = true})
vim.keymap.set({"n", "v"}, "*", "f*", {noremap = true})
vim.keymap.set({"n", "v"}, "#", "f#", {noremap = true})
vim.keymap.set({"n", "v"}, ".", "f.", {noremap = true})
vim.keymap.set({"n", "v"}, "'", "f'", {noremap = true})
vim.keymap.set({"n", "v"}, "\"", "f\"", {noremap = true})
vim.keymap.set({"n", "v"}, "=", "f=", {noremap = true})
vim.keymap.set({"n", "v"}, "!", "f!", {noremap = true})
vim.keymap.set({"n", "v"}, "/", "f/", {noremap = true})
vim.keymap.set({"n", "v"}, "<leader>f", "/", {noremap = true})
vim.keymap.set("n", "<leader>s", ":%s/", {noremap = true})
vim.keymap.set("v", "<leader>s", ":s/", {noremap = true})

-- commands for inserting empty lines
vim.keymap.set({"n", "o"}, "<leader>o", ":normal o<Esc>")
vim.keymap.set({"n", "o"}, "<leader>O", ":normal O<Esc>")

-- AltGr + asdfg for buffers
vim.keymap.set({"n", "v"}, "æ", '"a', { noremap = true })
vim.keymap.set({"n", "v"}, "ſ", '"s', { noremap = true })
vim.keymap.set({"n", "v"}, "ð", '"d', { noremap = true })
vim.keymap.set({"n", "v"}, "đ", '"f', { noremap = true })
vim.keymap.set({"n", "v"}, "ŋ", '"+', { noremap = true }) -- g for global buffer
-- AltGr + r for list of registers
vim.keymap.set({"n", "v"}, "¶", ":registers<cr>", { noremap = true })
