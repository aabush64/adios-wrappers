local wezterm = require 'wezterm'

local colors_module = {}

-- Set the colors dictionary
-- TODO: Change this to ${} values when porting to adios-wrappers
colors_module.theme = {
  bg0 = "#141617";
  bg1 = "#1D2021";
  bg2 = "#282828";
  bg3 = "#32302F";
  bg4 = "#3C3836";
  bg5 = "#504945";
  bg6 = "#665C54";
  bg7 = "#7C6F64";
  bg8 = "#928374";

  -- FG Goes from brightest to darkest 0 -> 1
  -- You usually wanna start at fg1 for text
  fg_flashbang = "#F9F5D7";
  fg0 = "#FBF1C7";
  fg1 = "#EBDBB2";
  fg2 = "#D5C4A1";
  fg3 = "#BDAE93";
  fg4 = "#A89984";
  fg5 = "#928374";

  grey = {
    dark = "#7C6F64";
    normal = "#928374";
    light = "#A89984";
  };

  red = {
    bg_diff = "#3C1F1E";
    bg_visual = "#442E2D";
    dark = "#9D0006";
    normal = "#CC241D";
    light = "#FB4934";
  };
   green = {
    bg_diff = "#32361A";
    bg_visual = "#333E34";
    dark = "#79740E";
    normal = "#98971A";
    light = "#B8BB26";
  };

  blue = {
    bg_diff = "#0D3138";
    bg_visual = "#2E3B38";
    dark = "#076678";
    normal = "#458588";
    light = "#83A598";
  };

  yellow = {
    bg_visual = "#473C29";
    dark = "#B57614";
    normal = "#D79921";
    light = "#FABD2F";
  };

  purple = {
    bg_visual = "#3C333B";
    dark = "#8F3F71";
    normal = "#B16286";
    light = "#D3869B";
  };

  aqua = {
    dark = "#427B58";
    normal = "#689D6A";
    light = "#8EC07C";
  };

  orange = {
    dark = "#AF3A03";
    normal = "#D65D0E";
    light = "#FE8019";
  };
}
Theme = colors_module.theme
-- End Theme
-- Bottom Text

-- Applies Color Scheme to Config
local function apply_scheme(config)
  config.colors = {
    foreground = Theme.fg1;
    background = Theme.bg1;

    cursor_bg = Theme.fg0;
    cursor_fg = Theme.bg0;
    cursor_border = Theme.fg_flashbang;

    selection_fg = Theme.bg3;
    selection_bg = Theme.fg3;

    scrollbar_thumb = Theme.fg4;

    split = Theme.fg2;

    ansi = {
      Theme.bg0,
      Theme.red.normal,
      Theme.green.normal,
      Theme.yellow.normal,
      Theme.blue.normal,
      Theme.purple.normal,
      Theme.aqua.normal,
      Theme.grey.normal
    };
    brights = {
      Theme.grey.light,
      Theme.red.light,
      Theme.green.light,
      Theme.yellow.light,
      Theme.blue.light,
      Theme.purple.light,
      Theme.aqua.light,
      Theme.fg_flashbang
    };

    compose_cursor = Theme.orange.normal;

    copy_mode_active_highlight_bg = { Color = Theme.green.bg_visual};
    copy_mode_active_highlight_fg = { Color = Theme.fg0 };
    copy_mode_inactive_highlight_bg = { Color = Theme.red.bg_visual };
    copy_mode_inactive_highlight_fg = { Color = Theme.fg0 };

    quick_select_label_bg = { Color = Theme.purple.bg_visual };
    quick_select_label_fg = { Color = Theme.fg0 };
    quick_select_match_bg = { Color = Theme.yellow.bg_visual };
    quick_select_match_fg = { Color = Theme.fg0 };

    input_selector_label_bg = { Color = Theme.blue.bg_visual; };
    input_selector_label_fg = { Color = Theme.fg1; };

    launcher_label_bg = { Color = Theme.bg4 };
    launcher_label_fg = { Color = Theme.fg2 };

    tab_bar = {
      background = Theme.fg5;

      active_tab = {
        bg_color = Theme.green.normal;
        fg_color = Theme.bg2;
      };

      inactive_tab = {
        bg_color = Theme.yellow.dark;
        fg_color = Theme.bg4
      };

      inactive_tab_hover = {
        bg_color = Theme.blue.light;
        fg_color = Theme.bg4
      };

      new_tab = {
        bg_color = Theme.red.dark;
        fg_color = Theme.fg4;
        italic = false
      }
    }
  }
  config.inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.9
  }
end

-- Finally apply all functions as needed
function colors_module.apply_colors(config)
  apply_scheme(config)
end

return colors_module
