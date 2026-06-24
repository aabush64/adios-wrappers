{...}: {
  options.keybindsFile.default = toString ./key_bindings.ron;
  options.symbolsFile.default = toString ./key_symbols.ron;
  options.themeFile.default = toString ./theme.ron;
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

  # options.symbols.default = {
  #   enter = "↲";
  #   left = "◄";
  #   right = "►";
  #   up = "▲";
  #   down = "▼";
  #   backspace = "←";
  #   home = "∑";
  #   end = "Ω";
  #   page_up = "△";
  #   page_down = "▽";
  #   tab = "→";
  #   back_tab = "↰";
  #   delete = "←";
  #   insert = ">";
  #   esc = "«";
  #   control = "^";
  #   shift = "⁊";
  #   alt = "⌥";
  # };

  # options.theme.default = {
  #   selected_tab = "#B8BB26";
  #   commit_author = "LightRed";
  # };
}
