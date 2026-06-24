{
  pkgs,
  adios,
  adios-wrappers,
}: let
  overrides = adios.lib.importModules ./.;
  root = {
    modules = pkgs.lib.recursiveUpdate adios-wrappers overrides;
  };
  wrappedModules = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
    };
  };
in
  builtins.mapAttrs (_: module: module {}) wrappedModules.modules
