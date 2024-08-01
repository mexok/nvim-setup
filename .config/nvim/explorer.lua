local set = vim.keymap.set

local function on_attach_nvim_tree(bufnr)
    local api = require "nvim-tree.api"
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set({'n', 'x'}, ']g', require('nvim-tree.api').node.navigate.git.next, opts('Git next'))
    vim.keymap.set({'n', 'x'}, '[g', require('nvim-tree.api').node.navigate.git.prev, opts('Git previous'))
    vim.keymap.set({'n', 'x'}, ']d', require('nvim-tree.api').node.navigate.diagnostics.next, opts('Diagnostics next'))
    vim.keymap.set({'n', 'x'}, '[d', require('nvim-tree.api').node.navigate.diagnostics.prev, opts('Diagnostics previous'))
    vim.keymap.set({'n', 'x'}, ']o', require('nvim-tree.api').node.navigate.opened.next, opts('Opened next'))
    vim.keymap.set({'n', 'x'}, '[o', require('nvim-tree.api').node.navigate.opened.prev, opts('Opened previous'))
    vim.keymap.set({'n', 'x'}, ']m', require('nvim-tree.api').marks.navigate.next, opts('Marks next'))
    vim.keymap.set({'n', 'x'}, '[m', require('nvim-tree.api').marks.navigate.prev, opts('Marks previous'))
end


require("nvim-tree").setup {
    renderer = {
        highlight_diagnostics = "name",
        highlight_git = "all",
        icons = {
          diagnostics_placement = "after",
          bookmarks_placement = "signcolumn",
        }
    },
    update_focused_file = {
        enable = true,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true
    },
    on_attach = on_attach_nvim_tree
}


-- nvim tree

local nvim_tree_open_file = require "nvim-tree.actions.node.open-file"
function vim.g.NVIM_TREE_OPEN_OR_FOCUS(mark)
    if mark and not mark.nodes then
        nvim_tree_open_file.fn("edit", mark.absolute_path)
    end
end

function vim.g.NVIM_TREE_GET_ORDERED_REL_PATHS()
    local paths = vim.tbl_map(function(n)
        local cwd = vim.fn.getcwd()
        local path = n.absolute_path
        if string.find(path, cwd, nil, true) ~= nil then
            path = string.sub(path, string.len(cwd)+2)
        end
        return path
    end, require("nvim-tree.marks").get_marks())

    table.sort(paths, function (a, b)
        -- Files in subdictionaries should be displayed before files.
        -- Also, names with a '-' and similiar should not be ordered
        -- before folders ('/').
        -- Thats why we modify the paths a bit to have a ' /1' before
        -- subdictionaries and a ' /2' before files
        local slash_cnt
        a, slash_cnt = string.gsub("/"..a, "/", " /2")
        a = string.gsub(a, "/2", "/1", slash_cnt - 1)
        b, slash_cnt = string.gsub("/"..b, "/", " /2")
        b = string.gsub(b, "/2", "/1", slash_cnt - 1)
        return string.lower(a) < string.lower(b)
    end)
    return paths
end

function vim.g.NVIM_TREE_REL_PATH_TO_ABS_PATH(path)
    local cwd = vim.fn.getcwd()
    if string.find(path, cwd, nil, true) == nil then
        path = cwd .. '/' .. path
    end
    return path
end

function vim.g.NVIM_TREE_SELECT(i)
    local paths = vim.g.NVIM_TREE_GET_ORDERED_REL_PATHS()
    local path = vim.g.NVIM_TREE_REL_PATH_TO_ABS_PATH(paths[i])
    local mark = require("nvim-tree.marks").get_mark { absolute_path = path }
    vim.g.NVIM_TREE_OPEN_OR_FOCUS(mark)
end

function vim.g.NVIM_TREE_SELECT_UI()
    local paths = vim.g.NVIM_TREE_GET_ORDERED_REL_PATHS()
    vim.ui.select(paths, {
        prompt = "Select mark",
    }, function(path)
        if path ~= nil then
            path = vim.g.NVIM_TREE_REL_PATH_TO_ABS_PATH(path)
            local mark = require("nvim-tree.marks").get_mark { absolute_path = path }
            vim.g.NVIM_TREE_OPEN_OR_FOCUS(mark)
        end
    end)
end

function vim.g.OPENED_NEXT()
    require('nvim-tree.api').node.navigate.opened.next()
    require('nvim-tree.api').node.open.edit()
end

function vim.g.OPENED_PREVIOUS()
    require('nvim-tree.api').node.navigate.opened.prev()
    require('nvim-tree.api').node.open.edit()
end

function vim.g.SIBLING_NEXT()
    require('nvim-tree.api').node.navigate.sibling.next()
    require('nvim-tree.api').node.open.edit()
end

function vim.g.SIBLING_PREVIOUS()
    require('nvim-tree.api').node.navigate.sibling.prev()
    require('nvim-tree.api').node.open.edit()
end


local harpoon = require("harpoon")

function vim.g.HARPOON_GLOB_MARKS()
    for i = 1, harpoon:list():length() do
        print(i..": "..harpoon:list():get(i).value)
    end
    if harpoon:list():length() == 0 then
        print("No marks")
    end
end

function vim.g.HARPOON_SELECT_MARKS()
    local paths = {}
    for i = 1, harpoon:list():length() do
        table.insert(paths, harpoon:list():get(i).value)
    end
    vim.ui.select(paths, {
        prompt = "Select mark",
    }, function(path)
        if path ~= nil then
            for i = 1, harpoon:list():length() do
                if harpoon:list():get(i).value == path then
                    vim.g.HARPOON_SELECT(i)
                    break
                end
            end
        end
    end)
end

function vim.g.HARPOON_SELECT(i)
    harpoon:list():select(i);
    harpoon:list()._index = i;
end

function vim.g.HARPOON_SORT()
    local nodes = {}
    for i = 1, harpoon:list():length() do
        table.insert(nodes, harpoon:list():get(i))
    end

    table.sort(nodes, function (a, b)
        -- Files in subdictionaries should be displayed before files.
        -- Also, names with a '-' and similiar should not be ordered
        -- before folders ('/').
        -- Thats why we modify the paths a bit to have a ' /1' before
        -- subdictionaries and a ' /2' before files
        a = a.value
        b = b.value
        local slash_cnt
        a, slash_cnt = string.gsub("/"..a, "/", " /2")
        a = string.gsub(a, "/2", "/1", slash_cnt - 1)
        b, slash_cnt = string.gsub("/"..b, "/", " /2")
        b = string.gsub(b, "/2", "/1", slash_cnt - 1)
        return string.lower(a) < string.lower(b)
    end)

    for i = 1, harpoon:list():length() do
        harpoon:list().items[i] = nodes[i]
    end
end

function vim.g.HARPOON_TOGGLE()
    local len = harpoon:list():length()
    harpoon:list():remove()

    for i = 1, len do
        if harpoon:list().items[i] == nil then
            harpoon:list().items[i] = harpoon:list().items[len]
            harpoon:list().items[len] = nil
            harpoon:list()._length = len - 1
            break
        end
    end

    if harpoon:list():length() == len then
        harpoon:list():add()
    end

    vim.g.HARPOON_SORT()
end

function vim.g.HARPOON_REFRESH()
    local len = harpoon:list():length()
    harpoon:list():remove()
    for i = 1, len do
        if harpoon:list().items[i] == nil then
            harpoon:list().items[i] = harpoon:list().items[len]
            harpoon:list()._length = len - 1
            harpoon:list():add()
            vim.g.HARPOON_SORT()
            break
        end
    end
    harpoon:sync()
end

function vim.g.HARPOON_GIT_DIFF_MARKS()
    local handle = io.popen("git status --porcelain | awk {'print $2'}")
    if handle == nil then
        print("Error populating marks from git diff")
        return
    end

    harpoon:list():clear()

    local result = handle:read("*a")
    handle:close()
    for name in string.gmatch(result, "[^\n]+") do
        harpoon:list():add({
            value = name,
            context = {
                row = 1,
                col = 0,
            },
        })
    end
    vim.g.HARPOON_REFRESH()
    print("Successfully populated marks from git diff")
end

vim.keymap.set("n", "wm", vim.g.HARPOON_TOGGLE)
vim.keymap.set("n", "mg", "<cmd>lua vim.g.HARPOON_GLOB_MARKS()<cr>", {noremap = true})
vim.keymap.set("n", "ms", "<cmd>lua vim.g.HARPOON_SELECT_MARKS()<cr>", {noremap = true})


for i = 1, 10 do
    vim.keymap.set("n", "m"..i%10, "<cmd>lua vim.g.HARPOON_SELECT("..i..")<cr>")
end

-- vim.keymap.set("n", "m1", function() harpoon:list():select(1); harpoon:list()._index = 1 end)
-- vim.keymap.set("n", "m2", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "m3", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "m4", function() harpoon:list():select(4) end)
-- vim.keymap.set("n", "m5", function() harpoon:list():select(5) end)
-- vim.keymap.set("n", "m6", function() harpoon:list():select(6) end)
-- vim.keymap.set("n", "m7", function() harpoon:list():select(7) end)
-- vim.keymap.set("n", "m8", function() harpoon:list():select(8) end)
-- vim.keymap.set("n", "m9", function() harpoon:list():select(9) end)
-- vim.keymap.set("n", "m0", function() harpoon:list():select(10) end)

vim.keymap.set("n", "mlgd", "<cmd>lua vim.g.HARPOON_GIT_DIFF_MARKS()<cr>")
vim.keymap.set("n", "mw", function() harpoon:list():prev() end)
vim.keymap.set("n", "me", function() harpoon:list():next() end)
vim.keymap.set("n", "mc", function() harpoon:list():clear() end)

-- set({"n", "x"}, "mt", "<cmd>set wrap!<cr>", { noremap=true, desc = 'Toggle wrap' })
-- set({"n", "x"}, "mw", require('nvim-tree.api').marks.navigate.prev)
-- set({"n", "x"}, "me", require('nvim-tree.api').marks.navigate.next)
-- set({"n", "x"}, "ma", vim.g.OPENED_NEXT)
-- set({"n", "x"}, "mx", vim.g.OPENED_PREVIOUS)
-- set({"n", "x"}, "ms", vim.g.NVIM_TREE_SELECT_UI)
-- set({"n", "x"}, "mc", require("nvim-tree.api").marks.clear)
-- for i = 1, 9 do
--     set({"n", "x"}, "m"..i, "<cmd>lua vim.g.NVIM_TREE_SELECT("..i..")<cr>")
-- end

set({"n", "x"}, "mv", ":Gvdiffsplit!<cr>", {desc="Show conflict in vsplit"})


-- windows

set({"n", "x"}, "w", "", { noremap=true })
set({"n", "x"}, "wh", "<c-w>h", { noremap=true })
set({"n", "x"}, "wj", "<c-w>j", { noremap=true })
set({"n", "x"}, "wk", "<c-w>k", { noremap=true })
set({"n", "x"}, "wl", "<c-w>l", { noremap=true })
set({"n", "x"}, "wf", "<cmd>w<cr>", { noremap=true, desc="Save file" })
set({"n", "x"}, "wr", "<cmd>e<cr>", { noremap=true, desc="Reload from file" })
set({"n", "x"}, "wR", "<cmd>e!<cr>", { noremap=true, desc="Forced reload from file" })
set({"n", "x"}, "we", "<cmd>q<cr>", { noremap=true, desc="Close file" })
set({"n", "x"}, "wE", "<cmd>qa<cr>", { noremap=true, desc="Close file" })
set({"n", "x"}, "wt", "<cmd>q!<cr>", { noremap=true, desc="Forced close of file" })
set({"n", "x"}, "wi", ":let @/ = ''<cr>", {desc="Unhighlight search"})
-- set({"n", "x"}, "wm", require("nvim-tree.api").marks.toggle)
set({"n", "x"}, "wn", vim.g.SIBLING_NEXT)
set({"n", "x"}, "wp", vim.g.SIBLING_PREVIOUS)
set({"n", "x"}, "wv", "<C-W>v", { noremap=true, desc="Split vertical" })
set({"n", "x"}, "ws", "<C-W>s", { noremap=true, desc="Split horizontal" })
