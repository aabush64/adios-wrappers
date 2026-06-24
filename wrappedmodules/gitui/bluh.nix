{
  keybinds = {
    move_left.char = "Char('h')";
    move_right.char = "Char('l')";
    move_up.char = "Char('k')";
    move_down.char = "Char('j')";

    popup_up.char = "Char('k')";
    popup_down.char = "Char('j')";

    stash_open.char = "Char('l')";

    tree_collapse_recursive = {
      char = "Char('H')";
      mod = "SHIFT";
    };
    tree_expand_recursive = {
      char = "Char('L')";
      mod = "SHIFT";
    };

    shift_up = {
      char = "Char('K')";
      mod = "SHIFT";
    };

    shift_down = {
      char = "Char('J')";
      mod = "SHIFT";
    };

    open_help.char = "F(1)";
    open_help.mod = "NONE";
    file_history.char = "F(2)";
    goto_line = {
      char = "Char('g')";
      mod = "CONTROL";
    };
  };

  # keybindsFile = toString ./key_bindings.ron;

  symbols = {
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
    shift = "⁊";
    alt = "⌥";
  };

  theme = {
    selected_tab = "#B8BB26";
    commit_author = "LightRed";
  };
}
