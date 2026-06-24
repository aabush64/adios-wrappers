{...}: {
  options = {
    configFile.default = ./starship.toml;
    wrapperAttrs.mutators = ["/git"];
  };

  mutations = {
    "/fish".interactiveShellInit = {
      options,
      inputs,
    }: let
      finalWrapper = options {};
      inherit (inputs.nixpkgs) lib;
    in
      /*
      fish
      */
      ''
        ${lib.getExe finalWrapper} init fish | source
        enable_transience
      '';
  };
}
