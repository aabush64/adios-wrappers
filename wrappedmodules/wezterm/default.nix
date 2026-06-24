{...}: {
  options.configFile.default = toString ./wezterm.lua;

  options.configModules.default = [
    (toString ./barformat.lua)
    (toString ./cider.lua)
    (toString ./colors.lua)
    (toString ./keys.lua)
    (toString ./wezterm.lua)
    (toString ./widgets.lua)
  ];
}
