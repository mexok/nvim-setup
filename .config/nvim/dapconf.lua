-- dap
local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-14',
    name = 'lldb'
}

dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'lldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},
    },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

-- start lsp via:
-- perl -MPerl::LanguageServer -e "Perl::LanguageServer::run" -- --port 27011 --version "2.5.0"
dap.adapters.perlsp = {
    type = 'server';
    host = '127.0.0.1';
    port = '27011';
}

dap.configurations.perl = {
    {
        name = 'Launch Perl';
        type = 'perlsp';
        request = 'launch';
        program = "${workspaceFolder}/${relativeFile}";
        reloadModules = true;
        stopOnEntry = false;
        cwd = "${workspaceFolder}";
    }
}

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
