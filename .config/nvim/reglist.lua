local set = vim.keymap.set

vim.g.REG_LIST_INDEX = 1

vim.g.GET_REGISTER_NAME = function(value)
    local values = {
        "a",  --  1
        "b",  --  2
        "c",  --  3
        "d",  --  4
        "e",  --  5
        "f",  --  6
        "g",  --  7
        "h",  --  8
        "i",  --  9
        "j",  -- 10
        "l",  -- 11
        "k",  -- 12
        "m",  -- 13
        "n",  -- 14
        "o",  -- 15
        "p",  -- 16
        "q",  -- 17
        "e",  -- 18
        "s",  -- 19
        "t",  -- 20
        "u",  -- 21
        "v",  -- 22
        "w",  -- 23
        "x",  -- 24
        "y",  -- 25
        "z",  -- 26
    }
    return values[value]
end

for i = 1, 20 do
    local reg = vim.g.GET_REGISTER_NAME(i)
    set({"n", "v"}, "<leader>r"..reg, "<cmd>lua vim.g.REG_LIST_INDEX = "..i.."<cr>", {desc="Set index to "..(i-1)})
end

vim.g.APPEND_REGISTER = function(value)
    local reg = vim.g.GET_REGISTER_NAME(vim.g.REG_LIST_INDEX)
    vim.fn.setreg(reg, value)
    vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX + 1
end

vim.g.GET_REGISTER = function(index)
    local reg = vim.g.GET_REGISTER_NAME(index)
    return vim.fn.getreg(reg)
end

vim.g.REG_LIST_IMPORT = function ()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    local line_start = vstart[2]
    local line_end = vend[2]
    for line = line_start, line_end do
        local content = vim.fn.getline(line)
        vim.g.APPEND_REGISTER(content)
    end
end

vim.g.REG_LIST_EXPORT = function ()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local t = {}
    for i = 1, vim.g.REG_LIST_INDEX - 1 do
        t[i] = vim.g.GET_REGISTER(i)
    end
    vim.api.nvim_buf_set_lines(0, row-1, row-1, 0, t)
end

vim.g.PRINT_REGISTER = function(i)
    print((i-1)..'-'..vim.g.GET_REGISTER_NAME(i)..': '..vim.g.GET_REGISTER(i))
end

set({"v"}, "<leader>li", "<esc><cmd>lua vim.g.REG_LIST_INDEX = 1; vim.g.REG_LIST_IMPORT()<cr>", {desc = 'Import reg list'})
set({"v"}, "<leader>la", "<esc><cmd>lua vim.g.REG_LIST_IMPORT()<cr>", {desc = 'Append reg list'})
set({"n"}, "<leader>le", "<cmd>lua vim.g.REG_LIST_EXPORT()<cr>", {desc = 'Export reg list'})
set({"v"}, "<leader>le", "d<cmd>lua vim.g.REG_LIST_EXPORT()<cr>", {desc = 'Export reg list'})
set({"n", "v"}, "<leader>lg", "<cmd>lua print(vim.g.REG_LIST_INDEX-1)<cr>", {desc = 'Print current index cnt'})
set({"n", "v"}, "<leader>lr", "<cmd>lua for i=1, vim.g.REG_LIST_INDEX - 1 do vim.g.PRINT_REGISTER(i) end<cr>", {desc = 'Print current registers'})
set("n", "<leader>lp", "<cmd>lua vim.fn.setreg('\"', vim.g.GET_REGISTER(vim.g.REG_LIST_INDEX)); vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX + 1<cr>p", {desc = 'Paste next'})
set("n", "<leader>lP", "<cmd>lua vim.fn.setreg('\"', vim.g.GET_REGISTER(vim.g.REG_LIST_INDEX)); vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX + 1<cr>P", {desc = 'Paste next'})
set("v", "<leader>lp", "<cmd>lua vim.fn.setreg('\"', vim.g.GET_REGISTER(vim.g.REG_LIST_INDEX)); vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX + 1<cr>P", {desc = 'Paste next'})

local reg_list_push_cmd = "<cmd>lua vim.g.APPEND_REGISTER(vim.fn.getreg('\"'))<cr>"
set("n", "<leader>lz", "yl"..reg_list_push_cmd, {desc = 'Yank next to list'})
set("n", "<leader>lZ", "Y"..reg_list_push_cmd, {desc = 'Yank until end of line to list'})
set("v", "<leader>lz", "y"..reg_list_push_cmd, {desc = 'Yank next to list'})
set("n", "<leader>ld", "x"..reg_list_push_cmd, {desc = 'Delete next to list'})
set("n", "<leader>lD", "D"..reg_list_push_cmd, {desc = 'Delete until end of line to list'})
set("v", "<leader>ld", "x"..reg_list_push_cmd, {desc = 'Delete next to list'})

set({"n", "v"}, "<leader>l+", "<cmd>lua vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX + 1; vim.g.PRINT_REGISTER(vim.g.REG_LIST_INDEX)<cr>", {desc = 'Increment current index'})
set({"n", "v"}, "<leader>l-", "<cmd>lua vim.g.REG_LIST_INDEX = vim.g.REG_LIST_INDEX - 1; vim.g.PRINT_REGISTER(vim.g.REG_LIST_INDEX)<cr>", {desc = 'Decrement current index'})
set({"n", "v"}, "<leader>lc", "<cmd>lua vim.g.REG_LIST_INDEX = 1; print(\"Reg list index resetted\")<cr>", {desc = 'Clear reg list index'})
