require('onedark').setup {
    style = 'darker',
    transparent = true,
    term_colors = true,

    highlights = {
        NvimTreeNormal = { fg = "#a0a8b7", bg = "#282c34" },
        NvimTreeNormalFloat = { fg = "#a0a8b7", bg = "#282c34" }
    }
}
require('onedark').load()

require('lualine').setup {
  options = {
    theme = 'onedark',
  },
  winbar = {
    lualine_a = {'branch'},
    lualine_b = {'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {'branch'},
    lualine_b = {'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  sections = {},
  inactive_sections = {}
}

-- require('which-key').setup {}

local rainbow_delimiters = require 'rainbow-delimiters'
require('rainbow-delimiters.setup').setup {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
    },
    query = {
        [''] = 'rainbow-delimiters',
    },
    priority = {
        [''] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterViolet',
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterOrange',
        'RainbowDelimiterCyan',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
    },
}

vim.keymap.set("n", "<F2>", "<cmd>lua require('rainbow-delimiters').toggle(0)<cr>", { noremap = true, desc = "toggle rainbow delimiters"})
