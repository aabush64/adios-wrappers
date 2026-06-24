{...}:

{
  inputs.themeJet.from = {parent}: parent.themeJet;
  
  options.configContents.defaultFunc = {inputs, ...}:
  let
    inherit (inputs.themeJet {}) theme;
    inherit (theme) hex;
  in
   ''
    [global]
    follow = keyboard
    enable_posix_regex = true

    width = 300
    height = (0, 150)
    offset = (8, 4)
    origin = top-right

    font = Departure Mono 10
    notification_limit = 6

    progress_bar = true
    progress_bar_height = 20
    progress_bar_min_width = 125

    format = "<b><i>%a</i></b><span fgcolor='${hex.fg0}'><b> - %s</b>\n%b</span>"

    gap_size = 10
    padding = 8
    horizontal_padding = 12

    line_height = 4

    [urgency_low]
    foreground="${hex.blue}"
    background="${hex.bg0}"
    highlight="${hex.blueLight}"
    frame_color="${hex.blueDark}"
    timeout = 3

    [urgency_normal]
    foreground="${hex.green}"
    background="${hex.bg0}"
    highlight="${hex.greenLight}"
    frame_color="${hex.greenDark}"
    timeout = 5

    [urgency_critical]
    foreground="${hex.redLight}"
    background="${hex.bg0}"
    highlight="${hex.white}"
    frame_color="${hex.redLight}"
    timeout = 10
  '';
}
