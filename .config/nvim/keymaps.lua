local set = vim.keymap.set

set("n", "<leader> ", " ", { noremap = true, desc = "escape leader"})

set("n", "<leader>f", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ theme = \"ivy\" })<cr>",
    { noremap = true, desc = "search text in project" })
set("v", "<leader>f", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); "..
    "require('telescope').extensions.live_grep_args.live_grep_args({ theme = \"ivy\", default_text = tmp })<cr>",
    { noremap = true, desc = "search marked text in project"})
set("n", "<leader>F", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, desc = "search files in project" })
set("v", "<leader>F", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').find_files({ default_text = tmp })<cr>", { noremap = true, desc = "search files in project with marked text"})
set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "explorer"})
set("n", "<leader>E", "<cmd>Oil<cr>", { desc = "nvim oil"})
set("n", "<leader>te", "<cmd>NvimTreeToggle<cr>", { desc = "explorer"})
set("n", "<leader>b", "<cmd>Git blame<cr>", { desc = "git blame"})
set("n", "<leader>a", "gg0vG$", { noremap = true, desc = "select all"})
set("n", "<leader>tv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>", { desc = "use python vulture for src dir" })
set("n", "<leader>H", ":h ", { noremap = true, desc = "help" })


--  macro recording

local function toggle_recording()
    local r = vim.fn.reg_recording()
    if r == '' then
        vim.api.nvim_feedkeys("qq", 'nx', false)
    else
        vim.api.nvim_feedkeys("q", 'nx', false)
    end
end

local function play_recorded()
    local r = vim.fn.reg_recording()
    if r ~= '' then
        vim.api.nvim_feedkeys("q", 'nx', true)
        local reg = vim.fn.getreg("q")
        reg = string.sub(reg, 1, -2)
        vim.fn.setreg("q", reg)
    end
    vim.api.nvim_feedkeys("@q", 'nx', true)
end

set({"n", "x"}, "q", toggle_recording, { noremap=true })
set({"n", "x"}, "<c-q>", "q", { noremap=true })
set({"n", "x"}, ".", play_recorded, { noremap=true })


-- autocomplete

function vim.g.CMP_SELECT(value)
    local cmp = require 'cmp'
    if cmp.visible() then
        for _ = 1, value do
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<tab>", true, false, true), 'm', false)
        end
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), 'm', false)
    end
end
for i = 0, 9 do
    set({"i", "s"}, "\\"..i, "<cmd>lua vim.g.CMP_SELECT("..i..")<cr>")
end

set({"i", "s"}, "<C-s>", function()
    require('luasnip').jump(1)
end, {silent = true})


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
set("n", "<leader>tf", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').frames).open()<cr>", { silent = true, desc = "open debug frames"})
set("n", "<leader>tt", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').threads).open()<cr>", { silent = true, desc = "open debug threads"})
set("n", "<leader>ts", "<cmd>lua require('dap.ui.widgets').sidebar(require('dap.ui.widgets').scopes).open()<cr>", { silent = true, desc = "open debug scopes"})
set("n", "<leader>tp", "<cmd>PackerUpdate<cr>", { noremap = true, desc = "update plugins"})
set("n", "<leader>to", "<cmd>SymbolsOutline<cr>")
set({"n", "x"}, "<leader>k", "<cmd>ToggleTerm<cr>")
set("n", "<leader>K", ":ToggleTermSendCurrentLine<cr>")
set("x", "<leader>K", ":ToggleTermSendVisualSelection<cr>")
set({"n", "x"}, "/", "/\\M")
set({"n", "x"}, "?", "?\\M")

-- lsp setup
set('n', 'gs', vim.lsp.buf.declaration, { noremap=true, silent=true, desc="go to declaration" })
set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true, desc="go to definition" })
set('n', 'gh', vim.lsp.buf.hover, { noremap=true, silent=true, desc="hover" })
set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true, desc="go to implementation" })
set('n', '<leader>N', vim.lsp.buf.rename, { noremap=true, silent=true, desc="rename" })
set('n', 'gr', vim.lsp.buf.references, { noremap=true, silent=true, desc="show references" })
set('n', '<leader>ö', function() vim.lsp.buf.format { async = false } end, { noremap=true, silent=true, desc="format file"})
set('n', '<leader>th', vim.diagnostic.open_float, { noremap=true, silent=true, desc="show diagnostics"})
set('n', '<leader>tl', vim.diagnostic.setloclist, { noremap=true, silent=true, desc="diagnostics quicklist"})
set('n', ']d', vim.diagnostic.goto_next, { noremap=true, silent=true, desc="diagnostics next"})
set('n', '[d', vim.diagnostic.goto_prev, { noremap=true, silent=true, desc="diagnostics previous"})

-- java specific
set('n', '<leader>jc', '<Cmd>lua require"jdtls".test_class()<CR>', { noremap=true })
set('n', '<leader>jf', '<Cmd>lua require"jdtls".test_nearest_method()<CR>', { noremap=true })

-- git gutter
set('n', ']g', '<Plug>(GitGutterNextHunk)', { noremap=true, desc="git next"})
set('n', '[g', '<Plug>(GitGutterPrevHunk)', { noremap=true, desc="git prev"})

-- editing

local kwords = "A-Za-z0-9_$%@"

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

set({"n", "v"}, "<C-k>", "K", {noremap=true})
set("i", "<C-j>", "<right><esc>Ji", {noremap=true})
set({"n", "v"}, "<C-j>", "J", {noremap=true})

set("n", "<C-p>", "vp", {noremap = true})
set("v", "<C-p>", "p", {noremap = true})
set("x", "p", "P", {noremap = true})

set("n", "<leader>s", ":%s/", {noremap = true})
set("x", "<leader>s", ":s/", {noremap = true})
set("n", "<leader>n", ":%norm ", {noremap = true})
set("x", "<leader>n", ":norm ", {noremap = true})
set("n", "<leader>g", ":%g/", {noremap = true})
set("x", "<leader>g", ":g/", {noremap = true})
set("n", "<leader>v", ":%v/", {noremap = true})
set("x", "<leader>v", ":v/", {noremap = true})
set("n", "<leader>r", ":%! perl -e", {noremap = true})
set("x", "<leader>r", ":! perl -e", {noremap = true})
set("n", "<leader>R", ":%! perl -e 'while(<>){print;}'", {noremap = true})
set("x", "<leader>R", ":! perl -e 'while(<>){print;}'", {noremap = true})

set("n", "ß", 'vi"', {noremap = true})
set("x", "ß", '<esc>vi"', {noremap = true})
set("n", "€", 'vi"f"oF"o', {noremap = true})
set("x", "€", '<esc>vi"f"oF"o', {noremap = true})

set("n", "ü", "vi'", {noremap = true})
set("x", "ü", "<esc>vi'", {noremap = true})
set("n", "Ü", "vi'f'oF'o", {noremap = true})
set("x", "Ü", "<esc>vi'f'oF'o", {noremap = true})

set("n", "ö", 'vib', {noremap = true})
set("x", "ö", '<esc>vib', {noremap = true})
set("n", "Ö", 'vibf)oF(o', {noremap = true})
set("x", "Ö", '<esc>vibf)oF(o', {noremap = true})

set("n", "ä", '<cmd>try|f{f}|catch||endtry<cr>vi{', {noremap = true})
set("x", "ä", '<esc><cmd>try|f{f}|catch||endtry<cr>vi{', {noremap = true})
set("n", "Ä", 'vi{f}oF{o', {noremap = true})
set("x", "Ä", '<esc>vi{f}oF{o', {noremap = true})

set({"i", "c", "o"}, "\"\"", "\"\"<Left>", { noremap=true })
set({"i", "c", "o"}, "\"<cr>", "\"<cr>\"<ESC>O", { noremap=true })
set({"i", "c", "o"}, "\"[", "\"\"\"<cr>\"\"\"<ESC>O", { noremap=true })
set({"i", "c", "o"}, "\"+", "\" +<cr>\"", { noremap=true })
set({"i", "c", "o"}, "''", "''<Left>", { noremap=true })
set({"i", "c", "o"}, "'<cr>", "'<cr>'<ESC>O", { noremap=true })
set({"i", "c", "o"}, "'[", "'''<cr>'''<ESC>O", { noremap=true })
set({"i", "c", "o"}, "'+", "' +<cr>'", { noremap=true })
set({"i", "c", "o"}, "()", "()<Left>", { noremap=true })
set({"i", "c", "o"}, "(<cr>", "(<cr>)<ESC>O", { noremap=true })
set({"i", "c", "o"}, "[]", "[]<Left>", { noremap=true })
set({"i", "c", "o"}, "[<cr>", "[<cr>]<ESC>O", { noremap=true })
set({"i", "c", "o"}, "{}", "{}<Left>", { noremap=true })
set({"i", "c", "o"}, "{<cr>", "{<cr>}<ESC>O", { noremap=true })
set({"i", "c", "o"}, "<>", "<lt>><Left>", { noremap=true })

set({"i", "c", "o"}, "<C-V>", "<C-R>", { noremap=true })
set({"i", "c", "o"}, "<C-V><C-V>", "<C-R>\"", { noremap=true })

vim.cmd([[
fun! SetKeymaps()

    nnoremap <nowait><buffer> > :cnext<cr>
    xnoremap <nowait><buffer> > :cnext<cr>
    nnoremap <nowait><buffer> < :cprevious<cr>
    xnoremap <nowait><buffer> < :cprevious<cr>

    nmap <nowait><buffer> <leader>> <leader>~pn
    xmap <nowait><buffer> <leader>> <leader>~pn
    nmap <nowait><buffer> <leader>< <leader>~pp
    xmap <nowait><buffer> <leader>< <leader>~pp

    nmap <nowait><buffer> } <leader>~fn
    xmap <nowait><buffer> } <leader>~fn
    nmap <nowait><buffer> { <leader>~fp
    xmap <nowait><buffer> { <leader>~fp

    nnoremap <leader>cr <Plug>(abolish-coerce-word)
    nnoremap <leader>ds <Plug>Dsurround
    nnoremap <leader>cs <Plug>Csurround
    nnoremap <leader>cS <Plug>CSurround
    nnoremap S v<Plug>VSurround
    xnoremap S <Plug>VSurround
    nnoremap gs v<Plug>VgSurround
    xnoremap gs <Plug>VgSurround
    nnoremap <nowait><buffer> <leader>ds<space> <Plug>Dsurround<space><space>
    nnoremap <nowait><buffer> S<space> v<Plug>VSurround<space><space>
    xnoremap <nowait><buffer> S<space> <Plug>VSurround<space><space>
    nnoremap <nowait><buffer> gs<space> v<Plug>VgSurround<space><space>
    xnoremap <nowait><buffer> gs<space> <Plug>VgSurround<space><space>
endfun

augroup set_keymaps
    autocmd!
    autocmd BufRead,BufNewFile,FilterReadPre,FileReadPre * :call SetKeymaps()
augroup end

call SetKeymaps()
]])
