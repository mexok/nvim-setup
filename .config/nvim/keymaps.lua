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

set("v", "/", "y/<C-R>\"<cr>", { noremap = true })
set("v", "?", "y?<C-R>\"<cr>", { noremap = true })

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
set({"n", "v"}, "<C-K>", "<cmd>ToggleTerm<cr>")
set("n", "<C-x>", ":ToggleTermSendCurrentLine<cr>")
set("v", "<C-x>", ":ToggleTermSendVisualSelection<cr>")

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

set({"n", "v"}, "<C-J>", "J", {noremap = true})

set("n", "J", "v:m '>+1<cr>gv=")
set("n", "K", "v:m '<-2<cr>gv=")
set("v", "J", ":m '>+1<cr>gv=gv")
set("v", "K", ":m '<-2<cr>gv=gv")
set("n", "<C-p>", "vp", {noremap = true})
set("v", "<C-p>", "p", {noremap = true})
set("v", "p", "P", {noremap = true})

set("n", "ä", 'vi"f"oF"o', {noremap = true})
set("v", "ä", '<esc>vi"f"oF"o', {noremap = true})
set("n", "Ä", 'vi"', {noremap = true})
set("v", "Ä", '<esc>vi"', {noremap = true})

set("n", "ü", "vi'f'oF'o", {noremap = true})
set("v", "ü", "<esc>vi'f'oF'o", {noremap = true})
set("n", "Ü", "vi'", {noremap = true})
set("v", "Ü", "<esc>vi'", {noremap = true})

set("n", "ö", 'vib', {noremap = true})
set("v", "ö", '<esc>vib', {noremap = true})
set("n", "Ö", 'vibf)oF(o', {noremap = true})
set("v", "Ö", '<esc>vibf)oF(o', {noremap = true})

set("n", "<leader>s", ":%s/", {noremap = true})
set("v", "<leader>s", ":s/", {noremap = true})
set("n", "<leader>g", ":%g/", {noremap = true})
set("v", "<leader>g", ":g/", {noremap = true})
set("n", "<leader>v", ":%v/", {noremap = true})
set("v", "<leader>v", ":v/", {noremap = true})

set({"n", "v"}, ".", ";", {noremap = true})
set({"n", "v"}, ";", ".", {noremap = true})

set("n", "L", ">>", {noremap = true})
set("n", "H", "<<", {noremap = true})
set("v", "L", ">gv", {noremap=true})
set("v", "H", "<gv", {noremap=true})
set({"n", "v"}, "<C-L>", "L", {noremap = true})
set({"n", "v"}, "<C-H>", "H", {noremap = true})

set({"n", "v"}, "<A-3>", "0", { noremap = true })
set({"n", "v"}, "<A-4>", "$", { noremap = true })
set({"n", "v"}, "0", "_", { noremap = true })
set("i", "<A-3>", "<esc>0i", { noremap = true })
set("i", "<A-4>", "<esc>$a", { noremap = true })
set("i", "<A-0>", "<esc>_i", { noremap = true })

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

set({"i", "c", "o"}, "<C-V>", "<C-R>", { noremap=true })
set({"i", "c", "o"}, "<C-V><C-V>", "<C-R>\"", { noremap=true })


set({"n", "v"}, "m", "<cmd>lua require(\"harpoon.mark\").add_file()<cr>")
set({"n", "v"}, "<leader>tm", "<cmd>lua require(\"harpoon.ui\").toggle_quick_menu()<cr>")

for i=1, 6 do
    set({"n", "v"}, "g"..i, "<cmd>lua require(\"harpoon.ui\").nav_file("..i..")<cr>")
end

vim.g.YANK_LIST_TMP = 1
vim.g.YANK_LIST_CNT = 1
vim.g.YANK_LIST_CONTENT = {}

vim.g.YANK_LIST_IMPORT = function ()
    vim.g.YANK_LIST_CLEAR()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    local line_start = vstart[2]
    local line_end = vend[2]
    for line = line_start, line_end do
        local content = vim.fn.getline(line)
        local m = vim.g.YANK_LIST_CONTENT
        m[vim.g.YANK_LIST_CNT] = content
        vim.g.YANK_LIST_CONTENT = m
        vim.g.YANK_LIST_CNT = vim.g.YANK_LIST_CNT + 1
    end
    vim.g.YANK_LIST_SETUP_NUM_KEYS()
end

vim.g.YANK_LIST_EXPORT = function ()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_lines(0, row-1, row-1, 0, vim.g.YANK_LIST_CONTENT)
end

vim.g.YANK_LIST_CLEAR = function ()
    vim.g.YANK_LIST_CNT = 1
    vim.g.YANK_LIST_TMP = 1
    vim.g.YANK_LIST_CONTENT = {}
    vim.g.YANK_LIST_SETUP_NUM_KEYS()
end

set({"v"}, "<leader>li", "<esc><cmd>lua vim.g.YANK_LIST_IMPORT()<cr>", {desc = 'Import yank list'})
set({"n"}, "<leader>le", "<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); vim.g.YANK_LIST_EXPORT()<cr>", {desc = 'Export yank list'})
set({"v"}, "<leader>le", "d<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); vim.g.YANK_LIST_EXPORT()<cr>", {desc = 'Export yank list'})
set({"n", "v"}, "<leader>lr", "<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Reset tmp cnt'})
set({"n", "v"}, "<leader>lg", "<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); print(vim.g.YANK_LIST_CNT-1)<cr>", {desc = 'Print current list cnt'})
set({"n", "v"}, "<leader>lt", "<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); print(vim.g.YANK_LIST_TMP-1)<cr>", {desc = 'Print current tmp cnt'})
set({"n", "v"}, "<leader>ll", "<cmd>lua vim.g.YANK_LIST_SETUP_NUM_KEYS(); for i=1, vim.g.YANK_LIST_CNT - 1 do print(i..': '..vim.g.YANK_LIST_CONTENT[i]) end<cr>", {desc = 'Print current registers'})
set({"n", "v"}, "<leader>lc", "<cmd>lua vim.g.YANK_LIST_CLEAR()<cr>", {desc = 'Clear yank list'})
set("n", "<leader>ln", "<cmd>lua vim.fn.setreg('\"', vim.g.YANK_LIST_CONTENT[vim.g.YANK_LIST_TMP]); vim.g.YANK_LIST_TMP = vim.g.YANK_LIST_TMP + 1<cr>p", {desc = 'Paste next'})
set("v", "<leader>ln", "<cmd>lua vim.fn.setreg('\"', vim.g.YANK_LIST_CONTENT[vim.g.YANK_LIST_TMP]); vim.g.YANK_LIST_TMP = vim.g.YANK_LIST_TMP + 1<cr>P", {desc = 'Paste next'})


for i=0, 9 do
    local char_t = {'"', "'", ",", ".", "[", "]", "(", ")", "{", "}", "$", "@", "%", "<", ">", "_", "-"}
    if (i == 0) then
        char_t = {0}  -- some performance optimization
    end
    for i_char, char in ipairs(char_t) do
        local f_t = {'f', 't'}
        for i_f, f in ipairs(f_t) do
            local tmp = i..f..char
            if (i == 0) then
                tmp = ''
            elseif (i == 1) then
                tmp = f..char
            end
            set("n", "<leader>la\""..tmp.."p", ":normal _"..tmp.."vi\"f\"oF\"o<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to outer "'})
            set("n", "<leader>li\""..tmp.."p", ":normal _"..tmp.."vi\"<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content to inner "'})
            set("n", "<leader>la'"..tmp.."p", ":normal _"..tmp.."vi'f'oF'o<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to outer \''})
            set("n", "<leader>li'"..tmp.."p", ":normal _"..tmp.."vi'<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content to inner \''})
            set("n", "<leader>lab"..tmp.."p", ":normal _"..tmp.."vab<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to outer block'})
            set("n", "<leader>lib"..tmp.."p", ":normal _"..tmp.."vib<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to inner block'})
            set("n", "<leader>law"..tmp.."p", ":normal _"..tmp.."vaw<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to outer word'})
            set("n", "<leader>liw"..tmp.."p", ":normal _"..tmp.."viw<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to inner word'})
            set("n", "<leader>laW"..tmp.."p", ":normal _"..tmp.."vaW<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to outer Word'})
            set("n", "<leader>liW"..tmp.."p", ":normal _"..tmp.."viW<leader>lnj<cr><cmd>lua vim.g.YANK_LIST_TMP = 1<cr>", {desc = 'Paste content buffer to inner Word'})

            set("n", "<leader>la\""..tmp.."z", ":normal _"..tmp.."vi\"f\"oF\"o<leader>lzj<cr>", {desc = 'Yank content buffer to outer "'})
            set("n", "<leader>li\""..tmp.."z", ":normal _"..tmp.."vi\"<leader>lzj<cr>", {desc = 'Yank content to inner "'})
            set("n", "<leader>la'"..tmp.."z", ":normal _"..tmp.."vi'f'oF'o<leader>lzj<cr>", {desc = 'Yank content buffer to outer \''})
            set("n", "<leader>li'"..tmp.."z", ":normal _"..tmp.."vi'<leader>lzj<cr>", {desc = 'Yank content to inner \''})
            set("n", "<leader>lab"..tmp.."z", ":normal _"..tmp.."vab<leader>lzj<cr>", {desc = 'Yank content buffer to outer block'})
            set("n", "<leader>lib"..tmp.."z", ":normal _"..tmp.."vib<leader>lzj<cr>", {desc = 'Yank content buffer to inner block'})
            set("n", "<leader>law"..tmp.."z", ":normal _"..tmp.."vaw<leader>lzj<cr>", {desc = 'Yank content buffer to outer word'})
            set("n", "<leader>liw"..tmp.."z", ":normal _"..tmp.."viw<leader>lzj<cr>", {desc = 'Yank content buffer to inner word'})
            set("n", "<leader>laW"..tmp.."z", ":normal _"..tmp.."vaW<leader>lzj<cr>", {desc = 'Yank content buffer to outer Word'})
            set("n", "<leader>liW"..tmp.."z", ":normal _"..tmp.."viW<leader>lzj<cr>", {desc = 'Yank content buffer to inner Word'})

            set("n", "<leader>la\""..tmp.."d", ":normal _"..tmp.."vi\"f\"oF\"o<leader>ldj<cr>", {desc = 'Delete content buffer to outer "'})
            set("n", "<leader>li\""..tmp.."d", ":normal _"..tmp.."vi\"<leader>ldj<cr>", {desc = 'Delete content to inner "'})
            set("n", "<leader>la'"..tmp.."d", ":normal _"..tmp.."vi'f'oF'o<leader>ldj<cr>", {desc = 'Delete content buffer to outer \''})
            set("n", "<leader>li'"..tmp.."d", ":normal _"..tmp.."vi'<leader>ldj<cr>", {desc = 'Delete content to inner \''})
            set("n", "<leader>lab"..tmp.."d", ":normal _"..tmp.."vab<leader>ldj<cr>", {desc = 'Delete content buffer to outer block'})
            set("n", "<leader>lib"..tmp.."d", ":normal _"..tmp.."vib<leader>ldj<cr>", {desc = 'Delete content buffer to inner block'})
            set("n", "<leader>law"..tmp.."d", ":normal _"..tmp.."vaw<leader>ldj<cr>", {desc = 'Delete content buffer to outer word'})
            set("n", "<leader>liw"..tmp.."d", ":normal _"..tmp.."viw<leader>ldj<cr>", {desc = 'Delete content buffer to inner word'})
            set("n", "<leader>laW"..tmp.."d", ":normal _"..tmp.."vaW<leader>ldj<cr>", {desc = 'Delete content buffer to outer Word'})
            set("n", "<leader>liW"..tmp.."d", ":normal _"..tmp.."viW<leader>ldj<cr>", {desc = 'Delete content buffer to inner Word'})
        end
    end
end

vim.g.YANK_LIST_SETUP_NUM_KEYS = function()
    for i=1, 9 do
        vim.keymap.set({"n", "v"}, "<leader>l"..i, "")
        vim.keymap.del({"n", "v"}, "<leader>l"..i)
        if (i < vim.g.YANK_LIST_CNT) then
            vim.keymap.set("n", "<leader>l"..i, "<cmd>lua vim.fn.setreg('\"', vim.g.YANK_LIST_CONTENT["..i.."])<cr>p", {desc = vim.g.YANK_LIST_CONTENT[i]})
            vim.keymap.set("v", "<leader>l"..i, "<cmd>lua vim.fn.setreg('\"', vim.g.YANK_LIST_CONTENT["..i.."])<cr>P", {desc = vim.g.YANK_LIST_CONTENT[i]})
        else
            vim.keymap.set({"n", "v"}, "<leader>l"..i, "<cmd>lua print(\"Buffer empty\")<cr>", {desc = "[Buffer empty]"})
        end
    end
end

vim.g.YANK_LIST_PUSH_FN = function()
    local m = vim.g.YANK_LIST_CONTENT
    m[vim.g.YANK_LIST_CNT] = vim.fn.getreg('"')
    vim.g.YANK_LIST_CONTENT = m
    vim.g.YANK_LIST_CNT = vim.g.YANK_LIST_CNT + 1
    vim.g.YANK_LIST_SETUP_NUM_KEYS()
end

local yank_list_push_cmd = '<cmd>lua vim.g.YANK_LIST_PUSH_FN()<cr>'
set("n", "<leader>lz", "yl"..yank_list_push_cmd, {desc = 'Yank next to list'})
set("v", "<leader>lz", "y"..yank_list_push_cmd, {desc = 'Yank next to list'})
set("n", "<leader>ld", "x"..yank_list_push_cmd, {desc = 'Delete next to list'})
set("v", "<leader>ld", "x"..yank_list_push_cmd, {desc = 'Delete next to list'})

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
    nnoremap S v<Plug>VSurround
    nnoremap gs v<Plug>VgSurround
    xnoremap S <Plug>VSurround
    xnoremap gs <Plug>VgSurround
endfun

augroup set_keymaps
    autocmd!
    autocmd FileType * :call SetKeymaps()
augroup end
]])
