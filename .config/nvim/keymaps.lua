local set = vim.keymap.set
set("n", "<leader> ", " ", { noremap = true, desc = "escape leader"})
set({"v", "n"}, "<leader>q", "<cmd>q<cr>", { noremap = true, desc = "quit" })
set({"v", "n"}, "<leader>Q", "<cmd>q!<cr>", { noremap = true, desc = "quit" })
set({"v", "n"}, "<leader>w", "<cmd>w<cr>", { noremap = true, desc = "write" })

set("n", "<leader>f", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args({ theme = \"ivy\" })<cr>",
    { noremap = true, desc = "search text in project" })
set("v", "<leader>f", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); "..
    "require('telescope').extensions.live_grep_args.live_grep_args({ theme = \"ivy\", default_text = tmp })<cr>",
    { noremap = true, desc = "search marked text in project"})
set("n", "<leader>F", "<cmd>lua require('telescope.builtin').find_files()<cr>", { noremap = true, desc = "search files in project" })
set("v", "<leader>F", "y:lua local tmp = string.gsub(vim.fn.getreg('\"'), '\\n.*', ''); require('telescope.builtin').find_files({ default_text = tmp })<cr>", { noremap = true, desc = "search files in project with marked text"})
set("n", "<leader>e", "<cmd>NvimTreeFocus<cr>", { desc = "explorer"})
set("n", "<leader>te", "<cmd>NvimTreeToggle<cr>", { desc = "explorer"})
set("n", "<leader>b", "<cmd>Git blame<cr>", { desc = "git blame"})
set("n", "<leader>a", "gg0vG$", { noremap = true, desc = "select all"})
set("n", "<leader>tv", "<cmd>cex system('PYTHONPATH=src vulture src/*') | copen<cr>", { desc = "use python vulture for src dir" })
set("n", "<leader>H", ":h ", { noremap = true, desc = "help" })
vim.g.SEARCH = function(key)
    local reg_start = vim.api.nvim_buf_get_mark(0, "<")
    local reg_end = vim.api.nvim_buf_get_mark(0, ">")
    local buff = vim.api.nvim_buf_get_text(0, reg_start[1]-1, reg_start[2], reg_start[1]-1, reg_end[2]+1, {})[1]
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), 'm', false)
    vim.api.nvim_feedkeys(buff, 'm', false)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<cr>", true, false, true), 'm', false)
end
set("x", "/", "<esc><cmd>lua vim.g.SEARCH('/')<cr>", { noremap = true })
set("x", "?", "<esc><cmd>lua vim.g.SEARCH('?')<cr>n", { noremap = true })

local nvim_tree_open_file = require "nvim-tree.actions.node.open-file"
local nvim_tree_utils = require "nvim-tree.utils"
function vim.g.NVIM_TREE_OPEN_OR_FOCUS(node)
    if node then
        if not node.nodes and not nvim_tree_utils.get_win_buf_from_path(node.absolute_path) then
            nvim_tree_open_file.fn("edit", node.absolute_path)
        else
            nvim_tree_utils.focus_file(node.absolute_path)
        end
    end
end

function vim.g.NVIM_TREE_SELECT(i)
    local paths = vim.tbl_map(function(n)
        return n.absolute_path
    end, require("nvim-tree.marks").get_marks())

    table.sort(paths)

    local node = require("nvim-tree.marks").get_mark { absolute_path = paths[i] }
    vim.g.NVIM_TREE_OPEN_OR_FOCUS(node)
end

function vim.g.NVIM_TREE_SELECT_UI()
    local paths = vim.tbl_map(function(n)
        return n.absolute_path
    end, require("nvim-tree.marks").get_marks())

    table.sort(paths)

    vim.ui.select(paths, {
        prompt = "Select mark",
    }, function(path)
        local node = require("nvim-tree.marks").get_mark { absolute_path = path }
        vim.g.NVIM_TREE_OPEN_OR_FOCUS(node)
    end)
end

set("n", "mw", require('nvim-tree.api').marks.navigate.prev)
set("n", "me", require('nvim-tree.api').marks.navigate.next)
set("n", "ms", vim.g.NVIM_TREE_SELECT_UI)
set("n", "mf", require("nvim-tree.api").marks.toggle)
set("n", "mc", require("nvim-tree.api").marks.clear)
for i = 1, 9 do
    set("n", "g"..i, "<cmd>lua vim.g.NVIM_TREE_SELECT("..i..")<cr>")
end

set("n", "mv", ":Gvdiffsplit!<cr>", {desc="Show conflict in vsplit"})

function vim.g.CMP_SELECT(value)
    local cmp = require 'cmp'
    if cmp.visible() then
        for i = 1, value do
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
set({"n", "v"}, "<leader>k", "<cmd>ToggleTerm<cr>")
set("n", "<leader>K", ":ToggleTermSendCurrentLine<cr>")
set("v", "<leader>K", ":ToggleTermSendVisualSelection<cr>")

-- lsp setup
set('n', 'gs', vim.lsp.buf.declaration, { noremap=true, silent=true, desc="go to declaration" })
set('n', 'gd', vim.lsp.buf.definition, { noremap=true, silent=true, desc="go to definition" })
set('n', 'gh', vim.lsp.buf.hover, { noremap=true, silent=true, desc="hover" })
set('n', 'gi', vim.lsp.buf.implementation, { noremap=true, silent=true, desc="go to implementation" })
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
set("i", "<A-L>", "<esc>Ea")
set("i", "<A-H>", "<right><esc>Bi")

set("i", "<A-a>", "<right><esc>", { noremap=true })
set("i", "<A-i>", "<esc>", { noremap=true })

set({"n", "v"}, "<leader>p", "\"+p", { noremap=true, desc="p using global buffer" })
set({"n", "v"}, "<leader>P", "\"+P", { noremap=true, desc="P using global buffer" })
set({"n", "v"}, "<leader>z", "\"+yl", { noremap=true, desc="z using global buffer" })
set({"n", "v"}, "<leader>Z", "\"+Y", { noremap=true, desc="Z using global buffer" })
set({"n", "v"}, "<leader>d", "\"+x", { noremap=true, desc="d using global buffer" })
set({"n", "v"}, "<leader>D", "\"+D", { noremap=true, desc="D using global buffer" })

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
set("i", "<C-e>", "<right><esc>ea", {noremap=true})

set({"n", "v"}, "<C-k>", "K", {noremap=true})
set("i", "<C-j>", "<right><esc>Ji", {noremap=true})
set({"n", "v"}, "<C-j>", "J", {noremap=true})

set("n", "<C-p>", "vp", {noremap = true})
set("v", "<C-p>", "p", {noremap = true})
set("x", "p", "P", {noremap = true})

set("n", "<leader>s", ":%s/", {noremap = true})
set("x", "<leader>s", ":s/", {noremap = true})
set("n", "<leader>g", ":%g/", {noremap = true})
set("x", "<leader>g", ":g/", {noremap = true})
set("n", "<leader>v", ":%v/", {noremap = true})
set("x", "<leader>v", ":v/", {noremap = true})
set("n", "<leader>r", ":%! perl -e 'while(<>){print;}'", {noremap = true})
set("x", "<leader>r", ":! perl -e 'while(<>){print;}'", {noremap = true})

set("n", "ä", 'vi"f"oF"o', {noremap = true})
set("x", "ä", '<esc>vi"f"oF"o', {noremap = true})
set("n", "Ä", 'vi"', {noremap = true})
set("x", "Ä", '<esc>vi"', {noremap = true})

set("n", "ü", "vi'f'oF'o", {noremap = true})
set("x", "ü", "<esc>vi'f'oF'o", {noremap = true})
set("n", "Ü", "vi'", {noremap = true})
set("x", "Ü", "<esc>vi'", {noremap = true})

set("n", "ö", 'vib', {noremap = true})
set("x", "ö", '<esc>vib', {noremap = true})
set("n", "Ö", 'vibf)oF(o', {noremap = true})
set("x", "Ö", '<esc>vibf)oF(o', {noremap = true})

set("n", "ß", 'vi{', {noremap = true})
set("x", "ß", '<esc>vi{', {noremap = true})
set("n", "€", 'vi{f}oF{o', {noremap = true})
set("x", "€", '<esc>vi{f}oF{o', {noremap = true})

set("i", "\"\"", "\"\"<Left>", { noremap=true })
set("i", "\"<cr>", "\"<cr>\"<ESC>O", { noremap=true })
set("i", "\"[", "\"\"\"<cr>\"\"\"<ESC>O", { noremap=true })
set("i", "\"+", "\" +<cr>\"", { noremap=true })
set("i", "''", "''<Left>", { noremap=true })
set("i", "'<cr>", "'<cr>'<ESC>O", { noremap=true })
set("i", "'[", "'''<cr>'''<ESC>O", { noremap=true })
set("i", "'+", "' +<cr>'", { noremap=true })
set("i", "()", "()<Left>", { noremap=true })
set("i", "(<cr>", "(<cr>)<ESC>O", { noremap=true })
set("i", "[]", "[]<Left>", { noremap=true })
set("i", "[<cr>", "[<cr>]<ESC>O", { noremap=true })
set("i", "{}", "{}<Left>", { noremap=true })
set("i", "{<cr>", "{<cr>}<ESC>O", { noremap=true })
set("i", "<>", "<lt>><Left>", { noremap=true })

set({"i", "c", "o"}, "<C-V>", "<C-R>", { noremap=true })
set({"i", "c", "o"}, "<C-V><C-V>", "<C-R>\"", { noremap=true })


vim.cmd([[
fun! SetKeymaps()
    nnoremap <nowait><buffer> d x
    xnoremap <nowait><buffer> d x
    xnoremap <nowait><buffer> D "_x
    nnoremap <nowait><buffer> s "_s
    xnoremap <nowait><buffer> s "_s
    nnoremap <nowait><buffer> c viw
    xnoremap <nowait><buffer> c <esc>viw
    nnoremap <nowait><buffer> C viW
    xnoremap <nowait><buffer> C <esc>viW
    nnoremap <nowait><buffer> x V
    xnoremap <nowait><buffer> x vvV
    nnoremap <nowait><buffer> yy zz
    xnoremap <nowait><buffer> yy zz
    nnoremap <nowait><buffer> y= z=
    xnoremap <nowait><buffer> y= z=
    nnoremap <nowait><buffer> z yl
    nnoremap <nowait><buffer> Z v$<left>y
    xnoremap <nowait><buffer> z y

    nnoremap <nowait><buffer> > vloho
    xnoremap <nowait><buffer> > loho
    nnoremap <nowait><buffer> < vholo
    xnoremap <nowait><buffer> < holo

    nnoremap <nowait><buffer> ' "
    xnoremap <nowait><buffer> ' "

    nnoremap <leader>cr <Plug>(abolish-coerce-word)
    nnoremap <leader>ds <Plug>Dsurround
    nnoremap <leader>cs <Plug>Csurround
    nnoremap <leader>cS <Plug>CSurround
    nnoremap S v<Plug>VSurround
    nnoremap gs v<Plug>VgSurround
    xnoremap S <Plug>VSurround
    xnoremap gs <Plug>VgSurround
endfun

augroup set_keymaps
    autocmd!
    autocmd BufRead,BufNewFile,FilterReadPre,FileReadPre * :call SetKeymaps()
augroup end

call SetKeymaps()
]])
