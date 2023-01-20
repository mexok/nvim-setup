-- dap
local dap = require('dap')

dap.adapters.python = {
    type = 'executable';
    command = 'python3';
    args = { '-m', 'debugpy.adapter' };
    enrich_config = function(config, on_config)
        local tmp_config = vim.deepcopy(config)
        env = {
            PYTHONPATH = 'src'
        }
        for line in string.gmatch(config.env.REG_F, "([^\r\n]+)") do
            k, v = string.match(line, "^%s*([%w%d_]+)=\"?([%w%d_=\\?]+)\"?")
            if v then
                env[k] = v
            end
        end
        tmp_config.env = env
        on_config(tmp_config)
    end;
}

dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
        cwd = "${workspaceFolder}";
        justMyCode = false;
        pythonPath = function()
            return 'python3'
        end;
        env = {
            REG_F = "${env:REG_F}";
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = "Pytest src";
        args = {"src"};
        module = "pytest";
        cwd = "${workspaceFolder}";
        justMyCode = false;
        pythonPath = function()
            return 'python3'
        end;
        env = {
            REG_F = "${env:REG_F}";
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = "Pytest file";
        args = {"${file}"};
        module = "pytest";
        cwd = "${workspaceFolder}";
        justMyCode = false;
        pythonPath = function()
            return 'python3'
        end;
        env = {
            REG_F = "${env:REG_F}";
        };
    },
    {
        type = 'python';
        request = 'launch';
        name = "Pytest single test";
        args = {"${file}::${env:REG_A}::${env:REG_S}"};
        module = "pytest";
        cwd = "${workspaceFolder}";
        justMyCode = false;
        pythonPath = function()
            return 'python3'
        end;
        env = {
            REG_F = "${env:REG_F}";
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


-- lsp
local lspconfig = require('lspconfig')
local lsp_defaults = lspconfig.util.default_config
lsp_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lsp_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

local servers = { 'pyright', 'tsserver', 'vuels'}
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        root_dir = function () return vim.fn.getcwd() end,
        settings = {
            python = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true
            }
        }
    }
end


-- cmp

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

local cmp = require 'cmp'

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Enter>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Select,
            select = false,
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
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    }
}

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})


-- to disable weired behavior when entering insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {update_in_insert = true}
)

require("dapui").setup()
