-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.scrollback_lines = 999999

config.quick_select_patterns = {
  '[\\w\\d]+',
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.enable_tab_bar = false

config.color_scheme = 'One Dark (Gogh)'

-- or, changing the font size and color scheme.
--config.font_size = 10
--config.color_scheme = 'AdventureTime'

local act = wezterm.action

config.keys = {
  {
    key = 'Escape',
    mods = 'NONE',
    action = act.Multiple {
      act.ClearSelection,
      act.CopyMode 'ClearPattern',
      act.SendKey { key = 'Escape' },
    },
  },
  {
    key = 'x',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(act.ActivateCopyMode, pane)
      window:perform_action(act.CopyMode('MoveToViewportTop'), pane)
    end),
  },
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      window:perform_action(act.ActivateCopyMode, pane)
      window:perform_action(act.CopyMode('MoveToViewportBottom'), pane)
      window:perform_action(act.Search { CaseInSensitiveString = '' }, pane)
    end),
  },
  { key = 'h', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(-1) },
  { key = 'l', mods = 'CTRL|SHIFT', action = act.MoveTabRelative(1) },
  {
    key = 'PageUp',
    mods = 'NONE',
    action = act.ScrollByPage(-1)
  },
  {
    key = 'PageDown',
    mods = 'NONE',
    action = act.ScrollByPage(1)
  },
  {
    key = 'PageUp',
    mods = 'SHIFT',
    action = wezterm.action.ScrollByLine(-1)
  },
  {
    key = 'PageDown',
    mods = 'SHIFT',
    action = wezterm.action.ScrollByLine(1)
  },
  {
    key = 'g',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  {
    key = 's',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Left',
      size = { Percent = 50 },
    },
  },
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Up',
      size = { Percent = 70 },
    },
  },
  {
    key = 'c',
    mods = 'CTRL|SHIFT',
    action = act.SplitPane {
      direction = 'Down',
      size = { Percent = 30 },
    },
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Left', 1 },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Down', 1 },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Up', 1 },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT|ALT',
    action = act.AdjustPaneSize { 'Right', 1 },
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = act.DisableDefaultAssignment,
  },
  {
    key = 'u',
    mods = 'CTRL',
    action = act.DisableDefaultAssignment,
  },
  {
    key = 'm',
    mods = 'CTRL|SHIFT',
    action = act.DisableDefaultAssignment,
  },
  {
    key = 'u',
    mods = 'CTRL|SHIFT',
    action = act.ActivateKeyTable {
      name = 'upane',
      timeout_milliseconds = 1000,
      one_shot=true
    },
  },
}


local copy_mode = nil
local search_mode = nil
if wezterm.gui then
  copy_mode = wezterm.gui.default_key_tables().copy_mode
  table.insert(
    copy_mode,
    {
      key = 'y',
      action = act.Multiple {
        { CopyTo = 'ClipboardAndPrimarySelection' },
      },
    }
  )

  search_mode =  wezterm.gui.default_key_tables().search_mode
  table.insert(
    search_mode,
    {
      key = 'n',
      mods = 'CTRL',
      action = act.CopyMode 'PriorMatch',
    }
  )
  table.insert(
    search_mode,
    {
      key = 'p',
      mods = 'CTRL',
      action = act.CopyMode 'NextMatch',
    }
  )
end

config.key_tables = {
  copy_mode = copy_mode,
  search_mode = search_mode,
  upane = {
    {
      key = '0',
      action = act.ActivateKeyTable {
        name = 'upane_0',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = '2',
      action = act.ActivateKeyTable {
        name = 'upane_2',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_0 = {
    {
      key = '0',
      action = act.ActivateKeyTable {
        name = 'upane_00',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_2 = {
    {
      key = '0',
      action = act.ActivateKeyTable {
        name = 'upane_20',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00 = {
    {
      key = 'c',
      action = act.ActivateKeyTable {
        name = 'upane_00c',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'd',
      action = act.ActivateKeyTable {
        name = 'upane_00d',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'e',
      action = act.ActivateKeyTable {
        name = 'upane_00e',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'f',
      action = act.ActivateKeyTable {
        name = 'upane_00f',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_20 = {
    {
      key = 'a',
      action = act.ActivateKeyTable {
        name = 'upane_20a',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00c = {
    {
      key = '4',
      action = act.ActivateKeyTable {
        name = 'upane_00c4',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00d = {
    {
      key = '6',
      action = act.ActivateKeyTable {
        name = 'upane_00d6',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'c',
      action = act.ActivateKeyTable {
        name = 'upane_00dc',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'f',
      action = act.ActivateKeyTable {
        name = 'upane_00df',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00e = {
    {
      key = '4',
      action = act.ActivateKeyTable {
        name = 'upane_00e4',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00f = {
    {
      key = '6',
      action = act.ActivateKeyTable {
        name = 'upane_00f6',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    },
    {
      key = 'c',
      action = act.ActivateKeyTable {
        name = 'upane_00fc',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_20a = {
    {
      key = 'c',
      action = act.ActivateKeyTable {
        name = 'upane_20ac',
        timeout_milliseconds = 1000,
        one_shot=true
      }
    }
  },
  upane_00c4 = {
    {
      mods = 'SHIFT',
      key = ' ', action = act.SendString "Ä"
    }
  },
  upane_00d6 = {
    {
      mods = 'SHIFT',
      key = ' ', action = act.SendString "Ö"
    }
  },
  upane_00dc = {
    {
      mods = 'SHIFT',
      key = ' ', action = act.SendString "Ü"
    }
  },
  upane_00e4 = {
    { key = ' ', action = act.SendString "ä" }
  },
  upane_00fc = {
    { key = ' ', action = act.SendString "ü" }
  },
  upane_00f6 = {
    { key = ' ', action = act.SendString "ö" }
  },
  upane_20ac = {
    {
      mods = 'SHIFT',
      key = ' ', action = act.SendString "€"
    }
  },
  upane_00df = {
    { key = ' ', action = act.SendString "ß" }
  },
}

config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}


wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    return tab.tab_title
  end
)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end

  return zoomed .. index .. tab.tab_title
end)

-- Finally, return the configuration to wezterm:
return config
