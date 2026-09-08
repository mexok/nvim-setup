local bundles = {
    vim.fn.glob("~/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar")
}
vim.list_extend(bundles, vim.split(vim.fn.glob("~/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))
-- an unmatched glob yields "", which jdtls would try to load as a bundle
bundles = vim.tbl_filter(function(jar) return jar ~= "" end, bundles)

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local home_dir = os.getenv("HOME")
local workspace_dir = home_dir..'/.local/workspace/'..project_name

-- jdtls ships one equinox configuration per platform; config_win has no _arm variant
local uname = vim.uv.os_uname()
local jdtls_os = ({ Darwin = 'mac', Windows_NT = 'win' })[uname.sysname] or 'linux'
local jdtls_arch = (uname.machine == 'arm64' or uname.machine == 'aarch64') and '_arm' or ''
local jdtls_config = 'config_'..jdtls_os..(jdtls_os == 'win' and '' or jdtls_arch)

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:'..home_dir..'/.local/share/nvim/mason/packages/jdtls/lombok.jar',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', vim.fn.glob("~/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
        '-configuration', home_dir..'/.local/share/nvim/mason/packages/jdtls/'..jdtls_config,
        '-data', workspace_dir
    },
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        settings = {
            java = {
                autobuild = {
                    enabled = false
                },
            },
        },
        bundles = bundles
    },
}
require('jdtls').start_or_attach(config)
