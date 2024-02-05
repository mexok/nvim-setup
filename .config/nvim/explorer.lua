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
        highlight_diagnostics = true,
        highlight_git = true,
        highlight_opened_files = "all",
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
        -- files in subdictionaries should be displayed before files
        -- thats why we modify the paths a bit to have a '/1' before
        -- subdictionaries and a '/2' before files
        local slash_cnt
        a, slash_cnt = string.gsub("/"..a, "/", "/2")
        a = string.gsub(a, "/2", "/1", slash_cnt - 1)
        b, slash_cnt = string.gsub("/"..b, "/", "/2")
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


set({"n", "x"}, "mt", "<cmd>set wrap!<cr>", { noremap=true, desc = 'Toggle wrap' })
set({"n", "x"}, "mw", require('nvim-tree.api').marks.navigate.prev)
set({"n", "x"}, "me", require('nvim-tree.api').marks.navigate.next)
set({"n", "x"}, "ma", vim.g.OPENED_NEXT)
set({"n", "x"}, "mx", vim.g.OPENED_PREVIOUS)
set({"n", "x"}, "ms", vim.g.NVIM_TREE_SELECT_UI)
set({"n", "x"}, "mc", require("nvim-tree.api").marks.clear)
for i = 1, 9 do
    set({"n", "x"}, "m"..i, "<cmd>lua vim.g.NVIM_TREE_SELECT("..i..")<cr>")
end

set({"n", "x"}, "mv", ":Gvdiffsplit!<cr>", {desc="Show conflict in vsplit"})
set({"n", "x"}, "m/", ":let @/ = ''<cr>", {desc="Show conflict in vsplit"})


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
set({"n", "x"}, "wt", "<cmd>q!<cr>", { noremap=true, desc="Forced close of file" })
set({"n", "x"}, "wm", require("nvim-tree.api").marks.toggle)
set({"n", "x"}, "wn", vim.g.SIBLING_NEXT)
set({"n", "x"}, "wp", vim.g.SIBLING_PREVIOUS)
