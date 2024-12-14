vim.cmd [[
fun! TrimWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

fun! RefreshGitGutter()
    execute ':GitGutterDisable'
    execute ':GitGutterEnable'
endfun

fun! SyncHarpoon()
    lua vim.g.HARPOON_SYNC()
endfun

fun! RefreshIndexHarpoon()
    lua vim.g.HARPOON_REFRESH_INDEX()
endfun

augroup trim_whitespaces
    autocmd!
    autocmd BufWritePre * :call TrimWhitespaces()
augroup end

augroup refresh_git_gutter
    autocmd!
    autocmd BufWritePost * :call RefreshGitGutter()
augroup end

augroup sync_harpoon
    autocmd!
    autocmd BufWritePost * :call SyncHarpoon()
    autocmd BufLeave * :call SyncHarpoon()
    autocmd BufUnload * :call SyncHarpoon()
augroup end

augroup refresh_index_harpoon
    autocmd!
    autocmd BufReadPost * :call RefreshIndexHarpoon()
    autocmd BufEnter * :call RefreshIndexHarpoon()
    autocmd BufNew * :call RefreshIndexHarpoon()
augroup end

augroup gofmt
    autocmd!
    autocmd BufWritePost *.go !gofmt -w %
augroup end

augroup initially_disable_rainbow_delimiters
    autocmd!
    autocmd BufEnter * :lua require('rainbow-delimiters').disable(0)
augroup end
]]

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
--    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
--    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


function _G.fix_perl_iskeyword()
    -- Somehow after opening a new perl file, ':' gets added to is keyword which makes things confusing.
    -- This is a dirty workaround.
    vim.opt.iskeyword:remove({":"})
end

vim.cmd('autocmd! BufEnter * lua fix_perl_iskeyword()')
