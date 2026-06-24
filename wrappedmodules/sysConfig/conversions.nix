{lib}: let
  inherit (builtins) mapAttrs attrValues concatStringsSep substring;
  inherit (lib.attrsets) mapAttrs' nameValuePair;
  hexDecDigits = rec {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    A = 10;
    B = 11;
    C = 12;
    D = 13;
    E = 14;
    F = 15;
  };

  hexRgbMath = hex:
    (16 * hexDecDigits."${substring 0 1 hex}"
    + hexDecDigits."${substring 1 1 hex}");
  
  # Gives us hexDecDigits but with digits as key and hex as value
  decHexDigits = mapAttrs'
    (name: value: nameValuePair
      (toString value) (toString name))
    hexDecDigits;

  rgbHexMath = value:
    map (x: decHexDigits.${toString x})
      [ (value / 16) (value - (value / 16) * 16) ];

in {
  # Converts an rgb attrset to hex string
  # rgb = { r = 24; g = 24; b = 24; }; => "#242424"
  rgbToHex = rgb_attrs:
    (x: "#${x.r}${x.g}${x.b}")
    (mapAttrs
      (name: value: concatStringsSep ""
        (rgbHexMath value))
      (rgb_attrs));


  hexToRgb = hex_string:
    (mapAttrs
      (name: value:
        hexRgbMath value)
    )
    {
      r = substring 1 2 hex_string;
      g = substring 3 2 hex_string;
      b = substring 5 2 hex_string;
    };

}
