vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { noremap = true })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { noremap = true })
vim.keymap.set("n", "<leader>r", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true })
vim.keymap.set("v", "<leader>r", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').find_files({ default_text = tmp })<cr>", { noremap = true })
vim.keymap.set("n", "<leader>s", "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
vim.keymap.set("v", "<leader>s", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').live_grep({ default_text = tmp })<cr>", { noremap = true })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { noremap = true })
vim.keymap.set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true })
vim.keymap.set("n", "<leader>b", "<cmd>Git blame<cr>", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>c", ":", { noremap = true })
vim.keymap.set("n", "<leader>a", "gg0vG$", { noremap = true })
vim.keymap.set("n", "<leader>tv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>")
vim.keymap.set("n", "<leader>H", ":h ", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>,", ",", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>.", ";", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>\"", "\"", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>p", "@", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>ü", "@@", { noremap = true })
vim.keymap.set({"n", "v"}, "s", "\"_s", { noremap = true })
vim.keymap.set({"n", "v"}, "<leader>l", "<cmd>lua vim.cmd(':'..vim.v.count)<cr>", { noremap = true })

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
local kwords = "A-Za-z0-9_"
local search_word_forward_begin = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)['..kwords..']", "e", vim.fn.line("w$")) end<cr>'
local search_word_forward_end = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("['..kwords..']\\\\(\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)", "", vim.fn.line("w$")) end<cr>'
local search_word_backward = '<cmd>lua for i=1, math.max(vim.v.count, 1) do vim.fn.search("\\\\(^\\\\|\\\\n\\\\|\\\\s\\\\|[^'..kwords..']\\\\)['..kwords..']", "be", vim.fn.line("w0")) end<cr>'
vim.keymap.set({"n", "o", "v"}, "w", search_word_forward_begin)
vim.keymap.set("i", "<A-w>", "<right><esc>"..search_word_forward_begin.."i")
vim.keymap.set({"n", "o", "v"}, "e", search_word_forward_end)
vim.keymap.set("i", "<A-e>", "<esc>"..search_word_forward_end.."a")
vim.keymap.set({"n", "o", "v"}, "b", search_word_backward)
vim.keymap.set("i", "<A-b>", "<right><esc>"..search_word_backward.."i")

vim.keymap.set("i", "<A-a>", "<right><esc>", { noremap=true })
vim.keymap.set("i", "<A-i>", "<esc>", { noremap=true })
vim.keymap.set("i", "<A-x>", "<del>", { noremap=true })
vim.keymap.set("i", "<A-l>", "<right>", { noremap=true })
vim.keymap.set("i", "<A-h>", "<left>", { noremap=true })

vim.keymap.set("i", "\"", "\"\"<left>", { noremap=true })
vim.keymap.set("i", "\"\"", "\"", { noremap=true })
vim.keymap.set("i", "\"<cr>", "\"<cr>\"<ESC>O", { noremap=true })
vim.keymap.set("i", "'", "''<left>", { noremap=true })
vim.keymap.set("i", "''", "'", { noremap=true })
vim.keymap.set("i", "'<cr>", "'<cr>'<ESC>O", { noremap=true })
vim.keymap.set("i", "(", "()<left>", { noremap=true })
vim.keymap.set("i", "()", "()", { noremap=true })
vim.keymap.set("i", "((", "(", { noremap=true })
vim.keymap.set("i", "(<cr>", "(<cr>)<ESC>O", { noremap=true })
vim.keymap.set("i", "[", "[]<left>", { noremap=true })
vim.keymap.set("i", "[]", "[]", { noremap=true })
vim.keymap.set("i", "[[", "[", { noremap=true })
vim.keymap.set("i", "[<cr>", "[<cr>]<ESC>O", { noremap=true })
vim.keymap.set("i", "{", "{}<left>", { noremap=true })
vim.keymap.set("i", "{}", "{}", { noremap=true })
vim.keymap.set("i", "{{", "{", { noremap=true })
vim.keymap.set("i", "{<cr>", "{<cr>}<ESC>O", { noremap=true })
vim.keymap.set("i", "<", "<><left>", { noremap=true })


-- remappings for better find
vim.g.mexoks_find = function(char)
    local search_text = char
    if char ~= "[" and char ~= "]" then
        search_text = "["..char.."]"
    end
    if char == "\\" then
        -- we have to encapsulate '\'
        search_text = "\\\\"
    end

    for i=1, math.max(vim.v.count, 1) do
        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
        local curr_char = string.sub(vim.api.nvim_get_current_line(), col+1, col+1)
        local opts = ""
        if curr_char ~= char then
            vim.fn.cursor(row, 1)
            opts = "c"
        end
        vim.fn.search(search_text, opts, vim.fn.line("w$"))
    end
end

vim.g.mexoks_findv = function(char)
    local search_text = char
    if char ~= "[" and char ~= "]" then
        search_text = "["..char.."]"
    end
    if char == "\\" then
        -- we have to encapsulate '\'
        search_text = "\\\\"
    end

    for i=1, math.max(vim.v.count, 1) do
        vim.fn.search(search_text, "", vim.fn.line("w$"))
    end
end

vim.cmd([[
function! SetBracketMappings()
    nnoremap <silent><nowait><buffer> [ <cmd>lua vim.g.mexoks_find('[')<cr>
    vnoremap <silent><nowait><buffer> [ <cmd>lua vim.g.mexoks_findv('[')<cr>
    nnoremap <silent><nowait><buffer> ] <cmd>lua vim.g.mexoks_find(']')<cr>
    vnoremap <silent><nowait><buffer> ] <cmd>lua vim.g.mexoks_findv(']')<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType * call SetBracketMappings()
augroup END
]])

local set_mexoks_find = function(char)
    if char == "\\" then
        vim.keymap.set("n", char, "<cmd>lua vim.g.mexoks_find('\\\\')<cr>", {noremap = true})
        vim.keymap.set("v", char, "<cmd>lua vim.g.mexoks_findv('\\\\')<cr>", {noremap = true})
    elseif char == "'"then
        vim.keymap.set("n", char, "<cmd>lua vim.g.mexoks_find('\\'')<cr>", {noremap = true})
        vim.keymap.set("v", char, "<cmd>lua vim.g.mexoks_findv('\\'')<cr>", {noremap = true})
    else
        vim.keymap.set("n", char, "<cmd>lua vim.g.mexoks_find('"..char.."')<cr>", {noremap = true})
        vim.keymap.set("v", char, "<cmd>lua vim.g.mexoks_findv('"..char.."')<cr>", {noremap = true})
    end
end

set_mexoks_find("@")
set_mexoks_find("$")
set_mexoks_find("%")
set_mexoks_find("&")
set_mexoks_find("?")
set_mexoks_find("_")
set_mexoks_find(":")
set_mexoks_find("<")
set_mexoks_find(">")
set_mexoks_find("{")
set_mexoks_find("}")
set_mexoks_find(")")
set_mexoks_find("(")
set_mexoks_find(",")
set_mexoks_find(";")
set_mexoks_find("-")
set_mexoks_find("+")
set_mexoks_find("*")
set_mexoks_find("#")
set_mexoks_find(".")
set_mexoks_find("'")
set_mexoks_find("\"")
set_mexoks_find("=")
set_mexoks_find("!")
set_mexoks_find("/")
set_mexoks_find("\\")
set_mexoks_find("~")

vim.keymap.set("n", "<leader>f", "/", {noremap = true})
vim.keymap.set("v", "<leader>f", "y/<C-R>\"", {noremap = true})
vim.keymap.set("n", "<leader>F", "?", {noremap = true})
vim.keymap.set("v", "<leader>F", "y?<C-R>\"", {noremap = true})
vim.keymap.set("n", "s", ":%s/", {noremap = true})
vim.keymap.set("v", "s", ":s/", {noremap = true})
vim.keymap.set("n", "<leader>g", ":%g/", {noremap = true})
vim.keymap.set("v", "<leader>g", ":g/", {noremap = true})
vim.keymap.set("n", "<leader>v", ":%v/", {noremap = true})
vim.keymap.set("v", "<leader>v", ":v/", {noremap = true})

-- AltGr + asdfg for buffers
vim.keymap.set({"n", "v"}, "æ", '"a', { noremap = true })
vim.keymap.set({"n", "v"}, "ſ", '"s', { noremap = true })
vim.keymap.set({"n", "v"}, "ð", '"d', { noremap = true })
vim.keymap.set({"n", "v"}, "đ", '"f', { noremap = true })
vim.keymap.set({"n", "v"}, "ŋ", '"+', { noremap = true }) -- g for global buffer

-- AltGr + r for list of registers
vim.keymap.set({"n", "v"}, "¶", ":registers<cr>", { noremap = true })
