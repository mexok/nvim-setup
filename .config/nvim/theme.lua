require('onedark').setup {
    style = 'darker',
    transparent = true,
    term_colors = true,
}
require('onedark').load()

require('lualine').setup {
  options = {
    theme = 'onedark',
  },
  winbar = {
    lualine_a = {'branch'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {'branch'},
    lualine_b = {'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}

require('which-key').setup {}

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
