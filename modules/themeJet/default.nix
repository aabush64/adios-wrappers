{ types, ... }@adios:
{
  inputs = {
    nixpkgs.from = { parent }: parent.nixpkgs;
  };

  options = {
    theme = {
      # Capitals to distinguish input vs output
      # Generalized theme file schema
      # {
      #   fg1.HEX = "#282828"
      #   fg2.RGB = {
      #     r = 24; g = 24; b = 24;
      #   }
      # }
      type = types.attrsOf (
        (types.struct "themeStruct" {
          HEX = types.string;
          RGB = types.attrsOf types.int;
        }).override
          {
            total = false;
            # Add a remove attrs so that other formats can be passed if wanted
            unknown = true;
          }
      );
      # Color Values we can Translate
      # RGB - {r = 23; g = 24; b = 25;};
      # HEX - "#FBCC12";
      mutatorType = types.attrs;
      mergeFunc = adios.lib.merge.attrs.recursively;
    };

    # Aliases assigned after keys are generated but before the convenience functions so they can still be available
    aliases = {
      type = types.attrsOf types.string;
      mutatorType = types.attrs;
      mergeFunc = adios.lib.merge.attrs.flat;
    };
  };

  impl =
    {
      options,
      inputs,
    }:
    let
      inherit (inputs.nixpkgs.lib) toLower toUpper;
      inherit (import ./conversions.nix { inherit (inputs.nixpkgs) lib; }) rgbToHex hexToRgb;
      inherit (builtins)
        mapAttrs
        concatStringsSep
        attrValues
        removeAttrs
        ;

      genTheme =
        themeSet:
        mapAttrs (
          _: value:
          (
            if value ? RGB then
              { rgb = value.RGB; }
            else if value ? HEX then
              { rgb = hexToRgb (toUpper value.HEX); }
            else
              throw "You done fucked up"
          )
          // (
            if value ? HEX then
              { hex = value.HEX; }
            else if value ? RGB then
              { hex = rgbToHex value.RGB; }
            else
              throw "You done fucked up"
          )
          // (removeAttrs value [
            "HEX"
            "RGB"
          ])
        ) themeSet;

      addAliases =
        generatedTheme: aliases:
        mapAttrs (
          name: value:
          generatedTheme.${value} or throw
            "Can't alias ${name} to ${value}, does not exist in the generated theme."
        ) aliases;

      keysSansAlias = genTheme options.theme;
      keysWithAlias =
        if !(options ? aliases) then
          keysSansAlias
        else
          keysSansAlias // addAliases keysSansAlias options.aliases;
    in
    # Module isnt really usable if you're not... setting this?
    assert options ? theme;
    {
      # Prints out hex string in standard all caps
      hex = mapAttrs (_: value: value.hex) keysWithAlias;
      hexLow = mapAttrs (_: value: toLower value.hex) keysWithAlias;

      rgb = mapAttrs (
        _: value: concatStringsSep ", " (map toString (attrValues value.rgb))
      ) keysWithAlias;
      rgbList = mapAttrs (_: value: attrValues value.rgb) keysWithAlias;
    }
    // keysWithAlias;
}
