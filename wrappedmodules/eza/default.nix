{...}: {
  inputs = {
    # sysConfig.from = {parent}: parent.sysConfig;
    themeJet.from = {parent}: parent.themeJet;
  };

  options.flags.defaultFunc = {inputs}: [
    "-h"
    "-a"
    "-l"
    "-o"
    "--no-permissions"
    "--time-style=+%y-%m-%d %H:%M"
    "--icons=always"
    "--group-directories-first"
  ];

  mutations."/fish".abbreviations = _: {
    ezg = "eza --git";
    ezl = "eza -RT -L";
    ezld = "eza --total-size -RT -L ";
    ezlg = "eza --git --git-repos -RT -L";
    ezm = "eza --no-time --no-filesize";
  };

  options.themes.defaultFunc = {inputs}:
    (import ./themeyml.nix {
      inherit (inputs.themeJet {}) theme;
    });
}
