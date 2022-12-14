vim.cmd [[
fun! TrimWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup trim_whitespaces
    autocmd!
    autocmd BufWritePre * :call TrimWhitespaces()
augroup end
]]
