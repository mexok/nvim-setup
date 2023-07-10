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

require("lspconfig").cmake.setup({})
require("lspconfig").clangd.setup({})

--local perlConfig = {
--    cmd = { 'pls' },
--    settings = {
--        pls = {
--            syntax = {
--                enabled = true,
--                perl = '/usr/bin/perl'
--            },
--            cwd = ".",
--        }
--    }
--}
--require("lspconfig").perlpls.setup(perlConfig)

require'lspconfig'.perlnavigator.setup{
    settings = {
      perlnavigator = {
          perlPath = 'perl',
          enableWarnings = true,
          perltidyProfile = '',
          perlcriticProfile = '',
          perlcriticEnabled = false,
      }
    }
}

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
        ['<cr>'] = cmp.mapping.confirm{
            behavior = cmp.ConfirmBehavior.Select,
            select = false,
        },
        ['<tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-tab>'] = cmp.mapping(function(fallback)
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
