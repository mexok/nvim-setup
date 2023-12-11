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

augroup trim_whitespaces
    autocmd!
    autocmd BufWritePre * :call TrimWhitespaces()
    autocmd BufWritePost * :call RefreshGitGutter()
augroup end

augroup gofmt
    autocmd!
    autocmd BufWritePost *.go !gofmt -w %
augroup end

augroup cursor_shape_on_exit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver100-blinkwait100-blinkoff100-blinkon100
augroup end
]]

function _G.set_terminal_keymaps()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


function _G.fix_perl_iskeyword()
    -- Somehow after opening a new perl file, ':' gets added to is keyword which makes things confusing.
    -- This is a dirty workaround.
    vim.opt.iskeyword:remove({":"})
end

vim.cmd('autocmd BufEnter * lua fix_perl_iskeyword()')
