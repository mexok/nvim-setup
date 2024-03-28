local bundles = {
    vim.fn.glob("~/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar")
}
vim.list_extend(bundles, vim.split(vim.fn.glob("~/.local/share/nvim/mason/share/java-test/*.jar", 1), "\n"))

local config = {
    cmd = {'jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
    init_options = {
        bundles = bundles
    }
}
require('jdtls').start_or_attach(config)
