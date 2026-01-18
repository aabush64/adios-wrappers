{ adios }:
let
  inherit (adios) types;
in
{
  name = "fuzzel";

  inputs = {
    mkWrapper.path = "/mkWrapper";
    nixpkgs.path = "/nixpkgs";
  };

  options = {
    flags = {
      type = types.listOf types.string;
      description = ''
        Flags to be appended by default when running fuzzel.

        See the documentation for valid options:
        https://codeberg.org/dnkl/fuzzel/src/branch/master/doc/fuzzel.1.scd

        *Not* disjoint with `settings/configFile` but conflicting settings between the configuration and set flags may have unexpected behavior.
        Setting --config= and passing/generating a configuration *will* throw an assert error.
      '';
      # For PR consideration -- Make this disjoint with any sort of generated/passed configuration
      # Then the settings that are set via flag only become their own options
    };
    
    settings = {
      type = types.attrs;
      description = ''
        Settings to be injected into the wrapped package's `fuzzel.ini`.

        See the documentation for valid options:
        https://codeberg.org/dnkl/fuzzel/src/branch/master/doc/fuzzel.ini.5.scd
        
        Disjoint with the `configFile` option.
      '';
    };
    configFile = {
      type = types.pathLike;
      description = ''
        `fuzzel.ini` file to be injected into the wrapped package.

        See the documentation for syntax and valid options:
        https://codeberg.org/dnkl/fuzzel/src/branch/master/doc/fuzzel.ini.5.scd
        
        Disjoint with the `settings` option.
      '';
    };

    package = {
      type = types.derivation;
      description = "The fuzzel package to be wrapped.";
      defaultFunc = { inputs }: inputs.nixpkgs.pkgs.fuzzel;
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs.pkgs) writeText;
      inherit (inputs.nixpkgs.lib.generators) toIni;
      inherit (inputs.nixpkgs.lib.lists) mutuallyExclusive;
      inherit (builtins) head;
    in
    assert !(options ? settings && options ? configFile);
    let
      configFlag =
        if options ? configFile then
          [ "--config=${options.configFile}" ]
        else if options ? settings then
          [ "--config=${writeText "fuzzel.ini" (toIni options.settings)}" ]
        else
          [ ];
      flags =
        if options ? flags then
          assert (mutuallyExclusive options.flags configFlag);
          options.flags ++ configFlag
        else
          configFlag;
    in
    inputs.mkWrapper {
      name = "fuzzel";
      inherit (options) package;
      inherit flags;
      preWrap =
      if options ? settings || options ? configFile then
      ''
        exec $out/bin/fuzzel --check-config ${head configFlag}
      ''
      else "";
    };
}
