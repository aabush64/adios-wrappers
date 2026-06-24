local wezterm = require 'wezterm'
local act = wezterm.action

local binds = {}

local function navigate_pane(key, direction)
  return {
    key = key,
    action = act.ActivatePaneDirection(direction)
  }
end

local function split_pane(key, direction)
  return {
    key = key,
    action = act.SplitPane {
      direction = direction,
      size = { Percent = 50 }
    }
  }
end

local function adjust_pane(key, direction)
  return {
    key = key,
    action = act.AdjustPaneSize { direction, 5 }
  }
end

binds.keybinds = {
  {
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateCommandPalette
  },

  -- Reload Config -> Wezterm doesn't recognize config change from symlinks
  {
    key = 'F5',
    mods = 'LEADER',
    action = act.ReloadConfiguration
  },

  -- Pane Mods
  -- Navigate (LDR+w)
  {
    key = 'w',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'navigate_panes',
      one_shot = false,
      timeout_milliseconds = 1000
    }
  },

  -- Split (LDR+R)
  {
    key = 'R',
    mods = 'LEADER|SHIFT',
    action = act.ActivateKeyTable {
      name = 'split_panes',
      one_shot = false,
      timeout_milliseconds = 1000
    }
  },

  -- Adjust (LDR+r)
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'resize_panes',
      one_shot = false,
      timeout_milliseconds = 1000
    }
  },

  -- Close Pane (LDR|Ctrl+w)
  {
    key = 'w',
    mods = 'LEADER|CTRL',
    action = act.CloseCurrentPane { confirm = true }
  },

  -- Tab Mods
  -- Navigate Relative (LDR+W)
  {
    key = 'W',
    mods = 'LEADER|SHIFT',
    action = act.ActivateKeyTable {
      name = 'navigate_tabs',
      one_shot = false,
      timeout_milliseconds = 1000
    }
  },

  -- Open/Close Tabs
  {
    key = 'u',
    mods = 'LEADER|CTRL',
    action = act.ActivateKeyTable {
      name = 'tab_management',
      one_shot = false,
      timeout_milliseconds = 1000
    }
  }
}

binds.keytables = {
  resize_panes = {
    adjust_pane('h', 'Left'),
    adjust_pane('j', 'Down'),
    adjust_pane('k', 'Up'),
    adjust_pane('l', 'Right'),
    adjust_pane('LeftArrow', 'Left'),
    adjust_pane('DownArrow', 'Down'),
    adjust_pane('UpArrow', 'Up'),
    adjust_pane('RightArrow', 'Right'),
  },

  navigate_panes = {
    navigate_pane('h', 'Left'),
    navigate_pane('j', 'Down'),
    navigate_pane('k', 'Up'),
    navigate_pane('l', 'Right'),
    navigate_pane('LeftArrow', 'Left'),
    navigate_pane('DownArrow', 'Down'),
    navigate_pane('UpArrow', 'Up'),
    navigate_pane('RightArrow', 'Right'),
  },

  split_panes = {
    split_pane('h', 'Left'),
    split_pane('j', 'Down'),
    split_pane('k', 'Up'),
    split_pane('l', 'Right'),
    split_pane('LeftArrow', 'Left'),
    split_pane('DownArrow', 'Down'),
    split_pane('UpArrow', 'Up'),
    split_pane('RightArrow', 'Right'),
  },

  navigate_tabs = {
    { key = 's', action = act.ActivateTabRelative(-1) },
    { key = 'd', action = act.ActivateTabRelative(1) },
    { key = 'a', action = act.ActivateTab(0) },
    { key = 'f', action = act.ActivateTab(-1) }
  },

  tab_management = {
    { key = 't', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'w', action = act.CloseCurrentTab { confirm = true } }
  }
}

return binds
