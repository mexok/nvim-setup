let mapleader = " "

let g:python3_host_prog = '/usr/bin/python3'

set exrc
set foldmethod=indent
set foldlevel=99
set nohlsearch
set hidden

set number
set relativenumber
set scrolloff=10
set noerrorbells

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set noswapfile nobackup
set incsearch

set colorcolumn=80

call plug#begin()

" Theme
Plug 'agude/vim-eldar'

" Debugging
Plug 'puremourning/vimspector'

" Code-completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File lookup
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-lua/plenary.nvim'  " Needed for telescope

" File explorer
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Editor smoothness
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'David-Kunz/treesitter-unit'

" For git blame
Plug 'tpope/vim-fugitive'

Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

colorscheme eldar

nmap <silent> <A-q> <cmd>q<cr>
nmap <silent> <A-w> <cmd>w<cr>

let g:vimspector_base_dir=expand( '$HOME/.config/nvim/vimspector-config' )
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB', 'vscode-node-debug2', 'vscode-firefox-debug' ]
let g:vimspector_enable_mappings = 'HUMAN'
nmap <F1> <cmd>VimspectorReset<cr>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

inoremap <A-d> <Esc>

inoremap <expr> <A-l> coc#pum#visible() ? coc#pum#confirm() : "\<A-l>"
inoremap <expr> <A-ö> coc#pum#visible() ? "<Esc>" : "\<A-ö>"
inoremap <expr> <A-j> coc#pum#visible() ? coc#pum#next(1) : "\<A-j>"
inoremap <expr> <A-k> coc#pum#visible() ? coc#pum#prev(1) : "\<A-k>"
inoremap <expr> <A-h> coc#refresh()
nnoremap <leader>rn <Plug>(coc-rename)

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

nnoremap <leader>tt <cmd>NvimTreeToggle<cr>

nnoremap <leader>tp <cmd>PlugInstall<cr>
nnoremap <leader>tc <cmd>PlugClean<cr>

nnoremap <leader>gb <cmd>Git blame<cr>

" switch , ; to work better for search on German keyboards
nnoremap , ;
nnoremap ; ,

nnoremap <A-o> m`o<Esc>``
nnoremap <A-O> m`O<Esc>``

" AltGr + asdfg for buffers
noremap æ "a
noremap ſ "s
noremap ð "d
noremap đ "f
noremap ŋ "g
" AltGr + r for list of registers
noremap ¶ :registers<CR>

xnoremap iu :lua require"treesitter-unit".select()<CR>
xnoremap au :lua require"treesitter-unit".select(true)<CR>
onoremap iu :<c-u>lua require"treesitter-unit".select()<CR>
onoremap au :<c-u>lua require"treesitter-unit".select(true)<CR>


fun! TrimWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup TRIM_WHITESPACES
    autocmd!
    autocmd BufWritePre * :call TrimWhitespaces()
augroup END

lua << EOF
require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt" },
})
require("nvim-tree").setup()

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "python", "typescript", "javascript"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

