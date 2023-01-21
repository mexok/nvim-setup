require('onedark').setup {
    style = 'deep',
    term_colors = true,
}
require('onedark').load()

require('lualine').setup {
  options = {
    theme = 'onedark',
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

require('which-key').setup {}
