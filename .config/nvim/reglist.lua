local set = vim.keymap.set

vim.g.REGLIST_LEN = 0

vim.g.REGLIST_GET_NAME = function(value)
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

vim.g.REGLIST_GET_VALUE = function(index)
    local reg = vim.g.REGLIST_GET_NAME(index)
    return vim.fn.getreg(reg)
end

vim.g.REGLIST_TRIM_NEWLINE = function(value)
    value = string.gsub(value, "\n$", "")
    return value
end

--for i = 1, 9 do
--    local reg = vim.g.GET_REGISTER_NAME(i)
--    set({"n", "v"}, "<leader>r"..reg, "<cmd>lua vim.g.REG_LIST_INDEX = "..i.."<cr>", {desc="Set index to "..i})
--end

vim.g.REGLIST_PUSH = function()
    local value = vim.fn.getreg('\"')
    vim.g.REGLIST_LEN = vim.g.REGLIST_LEN + 1
    local reg = vim.g.REGLIST_GET_NAME(vim.g.REGLIST_LEN)
    vim.fn.setreg(reg, value)
end

vim.g.REGLIST_POP = function()
    if vim.g.REGLIST_LEN == 0 then
        print("Error: Reglist is empty")
        return
    end
    local reg = vim.g.REGLIST_GET_NAME(vim.g.REGLIST_LEN)
    vim.fn.setreg('\"', vim.fn.getreg(reg))
    vim.g.REGLIST_LEN = vim.g.REGLIST_LEN - 1
end

vim.g.REGLIST_SHIFT = function()
    if vim.g.REGLIST_LEN == 0 then
        print("Error: Reglist is empty")
        return
    end
    local reg = vim.g.REGLIST_GET_NAME(1)
    vim.fn.setreg('\"', vim.fn.getreg(reg))
    for i = 2, vim.g.REGLIST_LEN do
        local regnext = vim.g.REGLIST_GET_NAME(i)
        local content = vim.fn.getreg(regnext)
        vim.fn.setreg(reg, content)
        reg = regnext
    end
    vim.g.REGLIST_LEN = vim.g.REGLIST_LEN - 1
end

vim.g.REGLIST_UNSHIFT = function()
    vim.g.REGLIST_LEN = vim.g.REGLIST_LEN + 1
    local value = vim.fn.getreg('\"')
    for i = 1, vim.g.REGLIST_LEN do
        local reg = vim.g.REGLIST_GET_NAME(i)
        local content = vim.fn.getreg(reg)
        vim.fn.setreg(reg, value)
        value = content
    end
end

vim.g.REGLIST_IMPORT = function ()
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")
    local line_start = vstart[2]
    local line_end = vend[2]
    for line = line_start, line_end do
        local content = vim.fn.getline(line)
        vim.g.REGLIST_PUSH(content)
    end
end

vim.g.REGLIST_EXPORT = function ()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local t = {}
    for i = 1, vim.g.REGLIST_LEN do
        t[i] = vim.g.REGLIST_SHIFT()
        t[i] = vim.g.REGLIST_TRIM_NEWLINE(t[i])
    end
    vim.api.nvim_buf_set_lines(0, row-1, row-1, 0, t)
end

vim.g.REGLIST_PRINT = function(i)
    print(i..'-'..vim.g.REGLIST_GET_NAME(i)..': '..vim.g.REGLIST_TRIM_NEWLINE(vim.g.REGLIST_GET_VALUE(i)))
end

vim.g.REGLIST_GLOB = function()
    if vim.g.REGLIST_LEN == 0 then
        print("Reglist is empty")
        return
    end
    for i=1, vim.g.REGLIST_LEN do
        vim.g.REGLIST_PRINT(i)
    end
end

set({"v"}, "<leader>li", "<esc><cmd>vim.g.REGLIST_IMPORT()<cr>", {desc = 'Import reg list'})
set({"n"}, "<leader>le", "<cmd>lua vim.g.REGLIST_EXPORT()<cr>", {desc = 'Export reg list'})
set({"v"}, "<leader>le", "d<cmd>lua vim.g.REGLIST_EXPORT()<cr>", {desc = 'Export reg list'})
set({"n", "v"}, "<leader>lg", "<cmd>lua vim.g.REGLIST_GLOB()<cr>", {desc = 'Print current registers'})
set({"n", "v"}, "<leader>lr", "<cmd>lua print(vim.g.REGLIST_LEN)<cr>", {desc = 'Print current reg list size'})

set("n", "<leader>lp", "<cmd>lua vim.g.REGLIST_POP()<cr>p", {desc = 'Pop and paste'})
set("n", "<leader>lP", "<cmd>lua vim.g.REGLIST_POP()<cr>P", {desc = 'Pop and paste'})
set("v", "<leader>lp", "<cmd>lua vim.g.REGLIST_POP()<cr>P", {desc = 'Pop and paste'})

set("n", "<leader>ls", "<cmd>lua vim.g.REGLIST_SHIFT()<cr>p", {desc = 'Shift and paste'})
set("n", "<leader>lS", "<cmd>lua vim.g.REGLIST_SHIFT()<cr>P", {desc = 'Shift and paste'})
set("v", "<leader>ls", "<cmd>lua vim.g.REGLIST_SHIFT()<cr>P", {desc = 'Shift and paste'})

set("n", "<leader>lz", "yl<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Yank and push'})
set("n", "<leader>lZ", "Y<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Yank and push'})
set("v", "<leader>lz", "y<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Yank and push'})
set("n", "<leader>ld", "x<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Delete and push'})
set("n", "<leader>lD", "D<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Delete and push'})
set("v", "<leader>ld", "x<cmd>lua vim.g.REGLIST_PUSH()<cr>", {desc = 'Delete and push'})

set("n", "<leader>lu", "yl<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Yank and unshift'})
set("n", "<leader>lU", "Y<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Yank and unshift'})
set("v", "<leader>lu", "y<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Yank and unshift'})
set("n", "<leader>lx", "yl<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Delete and unshift'})
set("n", "<leader>lX", "Y<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Delete and unshift'})
set("v", "<leader>lx", "y<cmd>lua vim.g.REGLIST_UNSHIFT()<cr>", {desc = 'Delete and unshift'})

set({"n", "v"}, "<leader>l+", "<cmd>lua vim.g.REGLIST_LEN = vim.g.REGLIST_LEN + 1; vim.g.REGLIST_GLOB()<cr>", {desc = 'Increment reglist size'})
set({"n", "v"}, "<leader>l-", "<cmd>lua vim.g.REGLIST_LEN = vim.g.REGLIST_LEN - 1; vim.g.REGLIST_GLOB()<cr>", {desc = 'Decrement reglist size'})
set({"n", "v"}, "<leader>lc", "<cmd>lua vim.g.REGLIST_LEN = 0; print(\"Reg list index resetted\")<cr>", {desc = 'Clear reg list'})
