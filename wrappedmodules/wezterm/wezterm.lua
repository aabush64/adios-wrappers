local wezterm = require 'wezterm'
-- Themes and Colors Module
local colorsmodule = require 'colors'
-- Bars Module
local bar_format = require 'barformat'

local config = wezterm.config_builder()

-- Globals for cache purposes
wezterm.GLOBAL.last_system_pull = wezterm.time.now()

-- Notify Reloads
wezterm.on('window-config.reloaded', function(window, pane)
  window:toast_notification('wezterm', 'configuration reloaded!', nil, 4000)
end)

-- Apply Le Color
colorsmodule.apply_colors(config)

-- Tab Bar Stuff
bar_format.apply_tab_style(config)
wezterm.on('format-tab-title', function(
    tab, tabs, panes, configs, hover, max_width
  )
  return bar_format.format_tabs(
    tab, tabs, panes, configs, hover, max_width
  )
end)
wezterm.on('update-status', function(window, pane)
  bar_format.status_update(window, pane)
end)

-- Font Configuration
config.font_size = 9.7
local default_font_stack = wezterm.font_with_fallback {
  'Departure Mono',
  'DepartureMono Nerd Font Mono',
  'JuliaMono'
}
config.font = default_font_stack

-- Command Palette
config.command_palette_font = default_font_stack
config.command_palette_font_size = 9.7
config.command_palette_fg_color = colorsmodule.theme.fg2

-- Window Configs
config.window_padding = {
  left = '1px',
  right = '1px',
  top = '0px',
  bottom = '0px'
}

config.initial_cols = 272
config.initial_rows = 75

-- Keyboard Configuration
config.leader = {
  key = 'Space',
  mods = 'CTRL',
  timeout_milliseconds = 2000
}
local binds = require 'keys'
config.keys = binds.keybinds
config.key_tables = binds.keytables

-- Keep from launching if shit is broken
config:set_strict_mode(true)
return config
