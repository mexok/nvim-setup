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
    view = {
        centralize_selection = false,
        number = true,
        relativenumber = true,
        float = {
            enable = true,
            open_win_config = function ()
                return {
                    relative = "editor",
                    border = "rounded",
                    row = 1,
                    col = 1,
                    height = vim.opt.lines:get()-5,
                    width = 9999,
                }
            end
        },
        width = 9999,
    },
    renderer = {
        highlight_diagnostics = "name",
        highlight_git = "all",
        icons = {
            diagnostics_placement = "after",
            bookmarks_placement = "signcolumn",
        },
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

-- harpoon
local harpoon = require("harpoon")
harpoon:setup({
    default = {
        display = function(list_item)
            local name = list_item.value
            name = string.gsub(name, ".*/", "")
            return name
        end,
    }
})

-- function vim.g.HARPOON_GLOB_MARKS()
--     for i = 1, harpoon:list():length() do
--         print(i..": "..harpoon:list():get(i).value)
--     end
--     if harpoon:list():length() == 0 then
--         print("No marks")
--     end
-- end

-- function vim.g.HARPOON_SELECT_MARK()
--     local paths = {}
--     for i = 1, harpoon:list():length() do
--         table.insert(paths, harpoon:list():get(i).value)
--     end
--     vim.ui.select(paths, {
--         prompt = "Select file",
--     }, function(path)
--         vim.g.HARPOON_SELECT_PATH(path)
--     end)
-- end

-- function vim.g.HARPOON_SELECT_MARK_SIMPLIFIED()
--     local paths = {}
--     for i = 1, harpoon:list():length() do
--         table.insert(paths, harpoon:list():get(i).value)
--     end
--     vim.g.SELECT_SIMPLIFIED(paths, vim.g.HARPOON_SELECT_PATH)
-- end

-- function vim.g.HARPOON_DELETE_MARK()
--     local paths = {}
--     for i = 1, harpoon:list():length() do
--         table.insert(paths, harpoon:list():get(i).value)
--     end
--     vim.ui.select(paths, {
--         prompt = "Delete mark",
--     }, function(path)
--         local len = harpoon:list():length()
--         for i = 1, len do
--             if path == harpoon:list():get(i).value then
--                 harpoon:list().items[i] = harpoon:list().items[len]
--                 harpoon:list().items[len] = nil
--                 harpoon:list()._length = len - 1
--                 vim.g.HARPOON_SORT()
--                 return
--             end
--         end
--     end)
-- end

-- function vim.g.HARPOON_SELECT_PATH(path)
--     if path ~= nil then
--         for i = 1, harpoon:list():length() do
--             if harpoon:list():get(i).value == path then
--                 vim.g.HARPOON_SELECT(i)
--                 break
--             end
--         end
--     end
-- end

-- function vim.g.HARPOON_SELECT(i)
--     harpoon:list():select(i);
--     harpoon:list()._index = i;
-- end

-- function vim.g.HARPOON_SORT()
--     local nodes = {}
--     for i = 1, harpoon:list():length() do
--         table.insert(nodes, harpoon:list():get(i))
--     end

--     vim.g.SORT_MARKS(nodes)

--     for i = 1, harpoon:list():length() do
--         harpoon:list().items[i] = nodes[i]
--     end
-- end

-- function vim.g.SORT_MARKS(nodes)
--     table.sort(nodes, function (a, b)
--         -- Files in subdictionaries should be displayed before files.
--         -- Also, names with a '-' and similiar should not be ordered
--         -- before folders ('/').
--         -- Thats why we modify the paths a bit to have a ' /1' before
--         -- subdictionaries and a ' /2' before files
--         if type(a) == "table" then
--             a = a.value
--         end
--         if type(b) == "table" then
--             b = b.value
--         end
--         local slash_cnt
--         a, slash_cnt = string.gsub("/"..a, "/", " /2")
--         a = string.gsub(a, "/2", "/1", slash_cnt - 1)
--         b, slash_cnt = string.gsub("/"..b, "/", " /2")
--         b = string.gsub(b, "/2", "/1", slash_cnt - 1)
--         return string.lower(a) < string.lower(b)
--     end)
-- end

-- function vim.g.HARPOON_ADD()
--     local len = harpoon:list():length()
--     harpoon:list():add()
--     if harpoon:list():length() ~= len then
--         print("Mark added")
--         vim.g.HARPOON_SORT()
--     else
--         print("File already added")
--     end
-- end

-- function vim.g.HARPOON_REMOVE()
--     local len = harpoon:list():length()
--     harpoon:list():remove()
--     local removed = 0
--     for i = 1, len do
--         if harpoon:list().items[i] == nil then
--             harpoon:list().items[i] = harpoon:list().items[len]
--             harpoon:list().items[len] = nil
--             harpoon:list()._length = len - 1
--             removed = 1
--             break
--         end
--     end

--     if removed == 1 then
--         print("Mark removed")
--         vim.g.HARPOON_SORT()
--     else
--         print("File already removed")
--     end
-- end

-- function vim.g.HARPOON_TOGGLE()
--     local len = harpoon:list():length()
--     harpoon:list():remove()

--     for i = 1, len do
--         if harpoon:list().items[i] == nil then
--             harpoon:list().items[i] = harpoon:list().items[len]
--             harpoon:list().items[len] = nil
--             harpoon:list()._length = len - 1
--             break
--         end
--     end

--     if harpoon:list():length() == len then
--         harpoon:list():add()
--         print("Mark added")
--     else
--         print("Mark removed")
--     end

--     vim.g.HARPOON_SORT()
-- end

-- function vim.g.HARPOON_REFRESH()
--     local len = harpoon:list():length()
--     harpoon:list():remove()
--     for i = 1, len do
--         if harpoon:list().items[i] == nil then
--             harpoon:list().items[i] = harpoon:list().items[len]
--             harpoon:list()._length = len - 1
--             harpoon:list():add()
--             vim.g.HARPOON_SORT()
--             break
--         end
--     end
--     harpoon:sync()
-- end
--
--
function vim.g.HARPOON_REFRESH_INDEX()
    local li = harpoon:list().config.create_list_item(harpoon:list().config)
    for i = 1, harpoon:list():length() do
        if harpoon:list():get(i) ~= nil and harpoon:list():get(i).value == li.value then
            harpoon:list()._index = i
            break
        end
    end
end

function vim.g.HARPOON_SYNC()
    harpoon:sync()
end

function vim.g.HARPOON_POPULATE_MARKS(cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print("Error populating marks: "..cmd)
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
    harpoon:sync()
    -- vim.g.HARPOON_REFRESH()
    print("Successfully populated marks with: "..cmd)
end

function vim.g.SHOW_FILES(cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print("Error executing: "..cmd)
        return
    end

    local result = handle:read("*a")
    handle:close()

    local paths = {}

    for name in string.gmatch(result, "[^\n]+") do
        table.insert(paths, name)
    end

    -- vim.g.SORT_MARKS(paths)

    vim.ui.select(paths, {
        prompt = "Select file",
    }, function(path)
        if path ~= nil then
            vim.cmd.edit(path)
        end
    end)
end

function vim.g.SHOW_FILES_SIMPLIFIED(cmd)
    local handle = io.popen(cmd)
    if handle == nil then
        print("Error executing: "..cmd)
        return
    end

    local result = handle:read("*a")
    handle:close()

    local paths = {}

    for name in string.gmatch(result, "[^\n]+") do
        table.insert(paths, name)
    end

    vim.g.SELECT_SIMPLIFIED(paths, vim.cmd.edit)
end


function vim.g.SELECT_SIMPLIFIED(paths, select_fn)
    local simplified_paths = {}

    for _, name in ipairs(paths) do
        local simplified_name = string.gsub(name, ".*/", "")

        if simplified_paths[simplified_name] == nil then
            simplified_paths[simplified_name] = {value = simplified_name, paths = {}}
        end
        table.insert(simplified_paths[simplified_name].paths, name)
    end

    local ui_selection = {}
    for key, _ in pairs(simplified_paths) do
        table.insert(ui_selection, key)
    end
    -- vim.g.SORT_MARKS(ui_selection)

    vim.ui.select(ui_selection, {
        prompt = "Select file",
    }, function(selected)
        if selected ~= nil then
            if #simplified_paths[selected].paths == 1 then
                select_fn(simplified_paths[selected].paths[1])
            else
                print("\n")
                vim.g.SORT_MARKS(simplified_paths[selected].paths)
                vim.ui.select(simplified_paths[selected].paths, {
                    prompt = "Specify file",
                }, function(specified)
                    if specified ~= nil then
                        select_fn(specified)
                    end
                end)
            end
        end
    end)
end

vim.keymap.set("n", "mf", function() harpoon:list():add(); harpoon:sync(); vim.g.HARPOON_REFRESH_INDEX() end)
vim.keymap.set("n", "ms", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "mw", function() harpoon:list():prev() end)
vim.keymap.set("n", "me", function() harpoon:list():next() end)

function vim.g.HARPOON_SELECT(i)
    harpoon:list():select(i)
end

for i = 1, 10 do
    vim.keymap.set("n", "m"..i%10, "<cmd>lua vim.g.HARPOON_SELECT("..i..")<cr>")
end

local cmd_all_files = "\"git status --porcelain | awk {'print $2'}\""
vim.keymap.set("n", "mls", "<cmd>lua vim.g.SHOW_FILES_SIMPLIFIED("..cmd_all_files..")<cr>")
vim.keymap.set("n", "mlfs", "<cmd>lua vim.g.SHOW_FILES("..cmd_all_files..")<cr>")
vim.keymap.set("n", "mles", "<cmd>lua vim.g.HARPOON_POPULATE_MARKS("..cmd_all_files..")<cr>")

local cmd_files_commit_base = "git show --pretty=\\\"\\\" --name-only HEAD~"
for i = 1, 10 do
    local d = i%10
    vim.keymap.set("n", "ml"..d, "<cmd>lua vim.g.SHOW_FILES_SIMPLIFIED(\""..cmd_files_commit_base..d.."\")<cr>")
    vim.keymap.set("n", "mlf"..d, "<cmd>lua vim.g.SHOW_FILES(\""..cmd_files_commit_base..d.."\")<cr>")
    vim.keymap.set("n", "mle"..d, "<cmd>lua vim.g.HARPOON_POPULATE_MARKS(\""..cmd_files_commit_base..d.."\")<cr>")
end

vim.keymap.set("n", "mw", function() harpoon:list():prev() end)
vim.keymap.set("n", "me", function() harpoon:list():next() end)
vim.keymap.set("n", "mc", function() harpoon:list():clear() end)


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
set({"n", "x"}, "wE", "<cmd>q!<cr>", { noremap=true, desc="Forced close file" })
set({"n", "x"}, "wt", "<cmd>qa<cr>", { noremap=true, desc="Close all files" })
set({"n", "x"}, "wT", "<cmd>qa!<cr>", { noremap=true, desc="Forced close all files" })
set({"n", "x"}, "wi", ":let @/ = ''<cr>", {desc="Unhighlight search"})
set({"n", "x"}, "wx", "<C-W>x", { noremap=true, desc="Swap windows" })
set({"n", "x"}, "wn", "<cmd>NvimTreeFocus<cr><cmd>lua vim.g.SIBLING_NEXT()<cr>")
set({"n", "x"}, "wp", "<cmd>NvimTreeFocus<cr><cmd>lua vim.g.SIBLING_PREVIOUS()<cr>")
set({"n", "x"}, "wv", "<C-W>v", { noremap=true, desc="Split vertical" })
set({"n", "x"}, "ws", "<C-W>s", { noremap=true, desc="Split horizontal" })
-- set({"n", "x"}, "wm", vim.g.HARPOON_TOGGLE)
-- set({"n", "x"}, "wa", vim.g.HARPOON_ADD)
-- set({"n", "x"}, "wd", vim.g.HARPOON_REMOVE)

-- navigating buffers
set("n", "{", "<cmd>bprev<cr>", { noremap=true, desc="buffer prev" })
set("n", "}", "<cmd>bnext<cr>", { noremap=true, desc="buffer next" })
