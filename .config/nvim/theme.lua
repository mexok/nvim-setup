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
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {'branch'},
    lualine_b = {'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {
    lualine_a = {'branch'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {'branch'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  }
}

require('which-key').setup {}
