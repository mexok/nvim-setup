-- dap setup

local dap = require('dap')

dap.adapters.python = {
    type = 'executable';
    command = 'python3';
    args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        cwd = "${workspaceFolder}";
        pythonPath = function()
            return 'python3'
        end;
        env = {
            PYTHONPATH = 'src'
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = "Pytest file";
        args = {"${file}"};
        module = "pytest";
        cwd = "${workspaceFolder}";
        pythonPath = function()
            return 'python3'
        end;
        env = {
            PYTHONPATH = 'src'
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = "Pytest single test";
        args = {"${file}::${env:REG_A}::${env:REG_S}"};
        module = "pytest";
        cwd = "${workspaceFolder}";
        pythonPath = function()
            return 'python3'
        end;
        env = {
            PYTHONPATH = 'src'
        };
    }
}

dap.adapters.firefox = {
    type = 'executable';
    command = 'node';
    args = { "/usr/lib/node_modules/firefox-debugadapter/adapter.bundle.js" }
}

dap.configurations.typescript = {
    {
        type = 'firefox';
        name = 'Debug 8080';
        request = 'launch';
        reAttach = true;
        url = 'http://localhost:8080';
        pathMappings = {
            {
                url = "webpack:///";
                path = "${workspaceFolder}/webapp"
            }
        }

    }
}

dap.configurations.vue = {
    {
        type = 'firefox';
        name = 'Debug 8080';
        request = 'launch';
        reAttach = true;
        url = 'http://localhost:8080';
        pathMappings = {
            {
                url = "webpack:///";
                path = "${workspaceFolder}/webapp"
            }
        }
    }
}


-- lsp setup
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
--vim.keymap.set('n', '<leader>[d', vim.diagnostic.goto_prev, opts)
--vim.keymap.set('n', '<leader>]d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>r', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>ea', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>er', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>el', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>n', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>F', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- lsp

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')
local servers = { 'pyright' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end


-- cmp setup

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require 'cmp'

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup {
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' }
    },
}

-- to disable weired behavior when entering insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {update_in_insert = true}
)
