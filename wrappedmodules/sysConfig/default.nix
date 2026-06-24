{types, ...} @ adios: {
  inputs = {
    nixpkgs.from = {parent}: parent.nixpkgs;
  };

  options = {
    themeFile = {
      # This gets used in an import, probably not wise to pathLike it
      type = types.path;
    };

    theme = {
      # Generalized theme file schema
      # {
      #   fg1.hex = "#282828"
      #   fg2.rgb = {
      #     r = 24; g = 24; b = 24;
      #   }
      # }
      type = types.attrs;
      # Color Values we can Translate
      # RGB - {r = 23; g = 24; b = 25;};
      # HEX - "#FBCC12";
      # HSL -- Lets wait to add this for now
      # HSV -- Lets wait to add this for now
      # OKCLH -- Lets wait to add this for now
      mutatorType = types.attrs;
      mergeFunc = adios.lib.merge.attrs.recursively;
    };

  };

  impl = {
    options,
    inputs,
  }: let
    inherit (inputs.nixpkgs.lib) toLower;
    inherit (import ./conversions.nix) rgbToHex hexToRgb;
    inherit (builtins) mapAttrs concatStringsSep attrValues;

    # This function will turn attrsets of the generalized schema (see above)
    # into attrs of this
    # {
    #   fg1 = {
    #     hex = "#ABCDEF";
    #     rgb = { r = 24; g = 24; b = 24; };
    #   };
    # }
    genTheme = themeSet:
      mapAttrs (
        name: value:
          (
            if value ? RGB
            then {rgb = value.RGB;}
            else if value ? HEX
            then {rgb = (hexToRgb value.HEX);}
            else throw "You done fucked up"
          )
          // (
            if value ? HEX
            then {hex = value.HEX;}
            else if value ? RGB
            then {hex = (rgbToHex value.RGB);}
            else throw "You done fucked up"
          )
      )
      themeSet;
  in
    assert !(options ? themeFile && options ? theme); rec {
      theme = rec {
        keys = (
          if options ? themeFile
          then genTheme (import options.themeFile {})
          else if options ? theme
          then genTheme options.theme
          else throw "How? Why?"
        );

        # Prints out hex string in standard all caps
        hex = mapAttrs (name: value: toLower value.hex) keys;
        hexLow = mapAttrs (name: value: value.hex) keys;

        rgb = mapAttrs (name: value:
          concatStringsSep "," (map toString (attrValues value.rgb)))
        keys;
        rgbList = mapAttrs (name: value:
          attrValues value.rgb)
        keys;
      };

      themeColors = theme.keys;
    };
}
