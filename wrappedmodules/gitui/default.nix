{...}: {
  inputs.themeJet.from = {parent}: parent.themeJet;
  options.keybindsFile.default = toString ./key_bindings.ron;
  # options.symbolsFile.default = toString ./key_symbols.ron;
  # options.themeFile.default = toString ./theme.ron;

  # options.keybinds.default = {
  #   move_left.char = "Char('h')";
  #   move_right.char = "Char('l')";
  #   move_up.char = "Char('k')";
  #   move_down.char = "Char('j')";

  #   popup_up.char = "Char('k')";
  #   popup_down.char = "Char('j')";

  #   stash_open.char = "Char('l')";

  #   tree_collapse_recursive = {
  #     char = "H";
  #     mod = "SHIFT";
  #   };
  #   tree_expand_recursive = {
  #     char = "L";
  #     mod = "SHIFT";
  #   };

  #   shift_up = {
  #     char = "K";
  #     mod = "SHIFT";
  #   };

  #   shift_down = {
  #     char = "J";
  #     mod = "SHIFT";
  #   };

  #   open_help.char = "F(1)";
  #   file_history.char = "F(2)";
  #   goto_line = {
  #     char = "Char('g')";
  #     mod = "CONTROL";
  #   };
  # };

  options.symbols.default = {
    enter = "↲";
    left = "◄";
    right = "►";
    up = "▲";
    down = "▼";
    backspace = "←";
    home = "∑";
    end = "Ω";
    page_up = "△";
    page_down = "▽";
    tab = "→";
    back_tab = "↰";
    delete = "←";
    insert = ">";
    esc = "«";
    control = "^";
    shift = "";
    alt = "⌥";
  };

  options.theme.defaultFunc = {inputs}: let
    inherit (inputs.themeJet {}) theme;
    inherit (theme) hex;
  in {
    selected_tab = hex.green;
    command_fg = hex.fg1;
    selection_bg = hex.blueDiff;
    selection_fg = hex.fg0;
    # use_selection_fg = hex.fg1;
    cmdbar_bg = hex.purpleDiff;
    disabled_fg = hex.grayDark;
    diff_line_add = hex.green;
    diff_line_delete = hex.red;
    diff_file_added = hex.green;
    diff_file_removed = hex.red;
    diff_file_moved = hex.blue;
    diff_file_modified = hex.yellow;
    commit_hash = hex.purple;
    commit_time = hex.blue;
    commit_author = hex.green;
    branch_fg = hex.orangeLight;
    danger_fg = hex.redLight;
    push_gauge_bg = hex.aquaDiff;
    push_gauge_fg = hex.fg0;
    tag_fg = hex.yellowLight;
    # line_break = "";
    # block_title_focused = hex.blueLight;
    
  };
}
