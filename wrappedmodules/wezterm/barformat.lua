-- Separate file for bar stuff
-- Colors file getting too cluttered
local wezterm = require 'wezterm'
local colors_module = require 'colors'

-- Local Vars using colors.lua themeing
local bar_format = {}

Theme = colors_module.theme
local bar_bg = Theme.fg5
local bar_fg = Theme.fg0

local tab_colors = {
  active = {
    bg = Theme.blue.dark,
    fg = Theme.fg0
  },
  last_active = {
    bg = Theme.yellow.dark,
    fg = Theme.fg0
  },
  inactive = {
    bg = Theme.green.dark,
    fg = Theme.fg0
  },
  new = {
    bg = Theme.red.dark,
    fg = Theme.fg0
  }
}

local unicodes = {
  gradient = {
    weakfg = '░',
    medfg = '▒',
    hardfg = '▓'
  },
  blocks = {
    right = {
      one_half = '▐',
      one_eight = '▕',
      one_four = '🮇',
      three_eight = '🮈',
      five_eight = '🮉',
      three_four = '🮊',
      seven_eight = '🮋'
    },
    left = {
      one_eight = '▏',
      one_four = '▎',
      three_eight = '▍',
      one_half = '▌',
      five_eight = '▋',
      three_four = '▊',
      seven_eight = '▉',
      block = '█',
    }
  }
}

-- Local Helper Functions
-- Title helper shamelessly yoinked from ref
local function tab_title(tab_info)
  local title = tab_info.tab_title
  if title and #title > 0 then
    return title
  end
  local working_title = tab_info.active_pane.title
  if working_title == '~' then
    return 'Home'
  end
  return tab_info.active_pane.title
end

-- Delimiter split shamelessly yoinked from stackoverflow
local function pipe_split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)')
  do
    table.insert(t, str)
  end
  return t
end

-- Update Status Functions
-- Left Status
local function left_update(window, pane)
  local mods, leds = window:keyboard_modifiers()
  local nums = '󱧓'
  local what = pipe_split(leds, '|')

  local num_theme = {
    bg = Theme.red.dark,
    fg = Theme.fg2
  }
  if not what then
  else
    for _, str in pairs(pipe_split(leds, '|')) do
      if str == 'NUM_LOCK' then
        nums = '󰎠'
        num_theme.bg = Theme.green.dark
      end
    end
  end

  local ldr_text = 'REG'
  local ldr_theme = {
    bg = Theme.orange.dark,
    fg = Theme.fg2
  }
  if window:leader_is_active() then
    ldr_text = 'LDR'
    ldr_theme.bg = Theme.purple.dark
  end

  return wezterm.format {
    { Background = { Color = num_theme.bg } },
    { Foreground = { Color = num_theme.fg } },
    { Text = ' ' .. nums .. ' ' },
    { Background = { Color = ldr_theme.bg } },
    { Foreground = { Color = ldr_theme.fg } },
    { Text = ' ' .. ldr_text .. ' ' }
  }
end
-- Right Status
local function right_update(window, pane)
  local time_theme = {
    fg = Theme.fg1,
    bg = Theme.bg1
  }

  return wezterm.format {
    { Background = { Color = time_theme.bg } },
    { Foreground = { Color = time_theme.fg } },
    { Attribute = { Italic = true } },
    { Text = wezterm.time.now():format(" %Y-%m-%d %H:%M:%S ")}
  }
end
-- Full
function bar_format.status_update(window, pane)
  window:set_left_status(left_update(window, pane))
  window:set_right_status(right_update(window, pane))
end

-- Tabs Dynamic
-- Function to handle 'format-tab-title' events
function bar_format.format_tabs(tab, tabs, panes, configs, hover, max_width)
  local index = tab.tab_index
  local num_panes = #panes
  local active = false
  local last_active = false

  -- Activity Determining Color
  local activity_color = tab_colors.inactive
  if tab.is_active then
    activity_color = tab_colors.active
    active = true
  end
  if tab.is_last_active then
    activity_color = tab_colors.last_active
    last_active = true
  end

  local display_color = {}
  if hover then
    display_color.fg = activity_color.bg
    display_color.bg = activity_color.fg
  else
    display_color.fg = activity_color.fg
    display_color.bg = activity_color.bg
  end

  -- Position Determining Text
  local prefix = ''
  local suffix = unicodes.blocks.left.block .. ' '

  if index == 0 then
    prefix = unicodes.blocks.left.block .. ''
  end
  local title = wezterm.truncate_right(tab_title(tab), max_width - 2)

  -- Final Text Return
  return {
    { Attribute = { Italic = last_active } },
    { Attribute = { Intensity = (active and "Bold" or "Normal") } },
    { Background = { Color = display_color.bg } },
    { Foreground = { Color = Theme.bg5 } },
    { Text = prefix },
    { Background = { Color = display_color.bg } },
    { Foreground = { Color = display_color.fg } },
    { Text = '║' .. index .. (active and ('∙' .. num_panes) or '') .. '║' },
    { Text = ' ' .. title },
    { Background = { Color = Theme.bg5 } },
    { Foreground = { Color = display_color.bg } },
    { Text = suffix }
  }
end

-- Tabs Static
-- Tab bar style for non-event format (new button)
function bar_format.apply_tab_style(config)
  config.tab_bar_style = {
    new_tab = wezterm.format {
      { Background = { Color = Theme.red.dark } },
      { Foreground = { Color = Theme.bg5 } },
      { Text = '' },
      { Background = { Color = Theme.red.dark } },
      { Foreground = { Color = Theme.bg1 } },
      { Text = ' + ' },
      { Background = { Color = Theme.fg5 } },
      { Foreground = { Color = Theme.bg1 } },
      { Text = unicodes.blocks.left.one_eight }
    },
    new_tab_hover = wezterm.format {
      { Background = { Color = Theme.fg2 } },
      { Foreground = { Color = Theme.bg5 } },
      { Text = '' },
      { Background = { Color = Theme.fg2 } },
      { Foreground = { Color = Theme.red.dark } },
      { Text = ' + ' },
      { Background = { Color = Theme.fg5 } },
      { Foreground = { Color = Theme.bg1 } },
      { Text = unicodes.blocks.left.one_eight} }
  }
  config.use_fancy_tab_bar = false
  config.enable_tab_bar = true
  config.show_tab_index_in_tab_bar = true
  config.tab_and_split_indices_are_zero_based = true
  config.tab_max_width = 35
end

return bar_format
