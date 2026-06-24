{...}:
{
  options.abbreviations.mutators = [ "/fish" "/eza" ];
  options.interactiveShellInit.mutators = [ "/fish" "/starship" ];

  mutations."/fish".abbeviations = _: {
    m = "man";

    nd = "nix develop";
    ne = "nix eval";
    nfu = "nix flake update";
    nfl = "nix flake lock";
  };

  mutations."/fish".interactiveShellinit = _: builtins.readFile ./config.fish;
}
